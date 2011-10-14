class Admin::Person < ActiveRecord::Base
  belongs_to :department, :class_name => 'Admin::Department'
  has_many :person_activity_relations, :class_name => 'Admin::PersonActivityRelation', :foreign_key => :person_id
  has_one :base_info, :class_name => 'InfoRegister::BaseInfo', :foreign_key => :owner_id

  #活动人员参加的所有活动
  def activities
    Admin::ReviewActivity.joins { :person_activity_relations }.
        where ({:person_activity_relations=>{:person_id=>self.id}})
  end

  #判定人员是否在指定活动中
  def in_activity? admin_review_activity
    people_in_activity = admin_review_activity.people_in_activity
    return people_in_activity.include? self
  end

  #人员参加一个活动，通过admin_review_activity.activity_type的类型来判定人员加入活动中role_type的类型
  def join_activity admin_review_activity
    #先判断人员是否已经在活动内
    if in_activity? admin_review_activity
      #如果在活动内不做处理
      return false;
    else
      #如果不再活动内，加入活动
      relation = Admin::PersonActivityRelation.new
      relation.activity=admin_review_activity
      #配置人员参加活动的初始状态，如果是info_register默认是pass，而其他为create
      #同时参与活动中的角色为模块info_register其他模块为配置review
      if admin_review_activity.activity_type=="info_register"
        relation.role_type="info_register"
        relation.activity_result="pass"
      else
        relation.role_type="review"
        relation.activity_result="create"
      end
      relation.person=self
      relation.save
      return true;
    end
  end

  #作为提供个人信息的方式加入一个活动
  #需要判定人员是否参与前置活动(有可能有多个)并且在所有前置活动中通过
  #如果没有则不可以参加本次活动 return false
  #如果成功添加返回添加的关系Admin::PersonActivityRelation
  def join_activity_as_info_register_role_type admin_review_activity
    #判定是否已经存在
    person_activity_relation = Admin::PersonActivityRelation.find_by_activity_id_and_person_id_and_role_type self.id, admin_review_activity.id,'info_register'
    return person_activity_relation unless person_activity_relation.nil?
    #不存在添加
    if join_activity_as_info_register_role_type? admin_review_activity
      as_info_register_role_type_relation = Admin::PersonActivityRelation.new
      as_info_register_role_type_relation.activity_id=admin_review_activity.id
      as_info_register_role_type_relation.person_id=self.id
      as_info_register_role_type_relation.role_type='info_register'
      as_info_register_role_type_relation.save
      return as_info_register_role_type_relation
    else
      return false
    end
  end

  #判定是否可以作为提供个人信息的方式加入一个活动
  #return false 需要判定人员是否参与前置活动(有可能有多个)并且在所有前置活动中通过
  #如果没有则不可以参加本次活动
  def join_activity_as_info_register_role_type? admin_review_activity
    can_join_activity = false;
    admin_review_activity.pre_activity_relations.each do |relation|
      if pass_activity? relation.pre_activity
        can_join_activity = true
      else
        can_join_activity=false;
        break;
      end
    end
    return can_join_activity;
  end

  #人员在该活动是否通过
  #return
  #如果人员不再活动中 false
  #如果人员活动中未通过 false
  #如果人员活动中通过 true
  def pass_activity? admin_review_activity
    relation = Admin::PersonActivityRelation.find_by_person_id_and_activity_id_and_role_type self.id, admin_review_activity.id,"info_register"
    return !relation.nil?&&relation.activity_result=='pass'
  end

  #退出活动
  def quit_activity admin_review_activity
    unless in_activity? admin_review_activity
      #如果在活动内不做处理
      return false;
    else
      relations = Admin::PersonActivityRelation.find_all_by_person_id_and_activity_id self.id, admin_review_activity.id
      relations.each do |relation|
        relation.destroy
      end
      return true;
    end
  end

  #设置人员参加活动时间
  def set_join_activity_time admin_review_activity, begin_time, end_time
    return false unless in_activity? admin_review_activity
    relation = Admin::PersonActivityRelation.find_by_person_id_and_activity_id self.id, admin_review_activity.id
    #理论上只可能有一个活动关联
    relation.login_begin_time=begin_time
    relation.login_end_time=end_time
    relation.save
    return true;
  end

  #获得人员参加活动的登录时间
  #return
  #如果人员不在活动中 {:type=>'not_in_activity'}
  #如果人员没有被特殊设置时间 {:type=>'no_activity_set_time',:begin_time=>..,:end_time=>..}
  #如果人员被特殊设置时间{:type=>'activity_set_time',:begin_time=>..,:end_time=>..}
  def join_activity_time admin_review_activity
    return {:type=>'not_in_activity'} unless in_activity? admin_review_activity
    relation = Admin::PersonActivityRelation.find_by_person_id_and_activity_id self.id, admin_review_activity.id
    if relation.nil?||relation.login_begin_time.blank?
      return {:type=>'no_activity_set_time'}
    else
      return {:type=>'activity_set_time', :begin_time=>relation.login_begin_time, :end_time=>relation.login_end_time}
    end
  end

  #设置是否组长is_leader?true:false 组长\非组长
  def set_activity_leader admin_review_activity, is_leader
    return false unless in_activity? admin_review_activity
    relation = Admin::PersonActivityRelation.find_by_person_id_and_activity_id self.id, admin_review_activity.id
    relation.is_leader=is_leader
    relation.save
    return true;
  end

  #获得现在可以参与的活动
  #根据活动时间、人员特殊时间设置判断
  def now_can_join_activities
    #排除掉活动时间已经过了的
    activities.select do |activity|
      now_can_join_activity? activity
    end
  end

  #判定人员是否可以参与到某个活动中（是否人员与活动产生关系，如果产生关系是否还需要判断在关系中承担的任务role_type:如果'info_register'
  #并且所在活动类型还不是info_register说明该人员在审核活动中充当信息提供者,详见Admin::PersonActivityRelation说明
  #，同时人员是否在可登录时间内，包括特殊时间的设置）
  #activity 活动
  def now_can_join_activity? activity
    if activity.activity_type == 'info_register'
      activity_relation = Admin::PersonActivityRelation.
          find_by_person_id_and_activity_id_and_role_type self.id, activity.id, 'info_register'
    else
      activity_relation = Admin::PersonActivityRelation.
          find_by_person_id_and_activity_id_and_role_type self.id, activity.id, 'review'
    end
    return false if activity_relation.nil?
    now_date_time = DateTime.now
    return true if Admin::ReviewActivity.can_login_by_rule? now_date_time, activity_relation.login_begin_time, activity_relation.login_end_time
    return Admin::ReviewActivity.can_login_by_rule? now_date_time, activity.begin_time, activity.end_time
  end

  #self person 被审核,options 审核结果
  def review_activity_by by_person, activity, options={}
    relation = Admin::PersonActivityRelation.
        find_by_activity_id_and_person_id_and_role_type activity.id, self.id, "info_register"
    relation.reviewer_id=by_person.id
    relation.review_time=DateTime.now
    relation.update_attributes options
    relation
  end

  #self person 活动进行确认
  def confirm_activity_by by_person, activity
    relation = Admin::PersonActivityRelation.
        find_by_activity_id_and_person_id_and_role_type activity.id, self.id, "info_register"
    relation.confirmor_id = by_person.id
    relation.confirm_time = DateTime.now
    relation.confirm_result="pass"
    relation.save
    relation
  end
end
