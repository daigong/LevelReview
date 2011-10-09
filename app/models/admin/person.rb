class Admin::Person < ActiveRecord::Base
  belongs_to :department, :class_name => 'Admin::Department'
  has_many :person_activity_relations, :class_name => 'Admin::PersonActivityRelation', :foreign_key => :person_id
  #判定人员是否在指定活动中
  def in_activity? admin_review_activity
    people_in_activity = admin_review_activity.people_in_activity
    return people_in_activity.include? self
  end

  #人员参加一个活动
  def join_activity admin_review_activity
    #先判断人员是否已经在活动内
    if in_activity? admin_review_activity
      #如果在活动内不做处理
      return false;
    else
      #如果不再活动内，加入活动
      relation = Admin::PersonActivityRelation.new
      relation.activity=admin_review_activity
      relation.person=self
      relation.save
      return true;
    end
  end

  #退出活动
  def quit_activity admin_review_activity
    unless in_activity? admin_review_activity
      #如果在活动内不做处理
      return false;
    else
      relations = Admin::PersonActivityRelation.find_all_by_person_id_and_activity_id self.id, admin_review_activity.id
      #理论上只可能有一个活动关联
      relations.each do |relation|
        relation.destroy
      end
      return true;
    end
  end

  #设置人员参加活动时间
  def set_join_activity_time admin_review_activity, begin_time, end_time
    return false if in_activity? admin_review_activity
    relation = Admin::PersonActivityRelation.find_by_person_id_and_activity_id self.id, admin_review_activity.id
    #理论上只可能有一个活动关联
    relation.login_begin_time=DateTime.parse(begin_time)
    relation.login_end_time=DateTime.parse(end_time)
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
end
