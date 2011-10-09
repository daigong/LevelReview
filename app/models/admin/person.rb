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

end
