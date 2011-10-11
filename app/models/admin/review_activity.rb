class Admin::ReviewActivity < ActiveRecord::Base
  belongs_to :review_project
  has_many :person_activity_relations,:class_name => 'Admin::PersonActivityRelation',:foreign_key => :activity_id
  #提供系统一个时间判断规则函数
  def self.can_login_by_rule? now_time, begin_time, end_time
    if begin_time.nil?&&end_time.nil?
      #均为空
      return false
    elsif begin_time.nil?&&!end_time.nil?
      #只设置结束时间
      return now_time<end_time
    elsif !begin_time.nil?&&end_time.nil?
      #只设置开始时间
      return begin_time<now_time
    elsif !begin_time.nil?&&!end_time.nil?
      #俩个都设置
      return begin_time<now_time&&now_time<end_time
    end
  end

  #参与该活动的所有人员
  def people_in_activity
    Admin::Person.joins(:person_activity_relations).where('admin_person_activity_relations.activity_id=?', self.id);
  end


end
