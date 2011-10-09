#encoding=utf-8
module Admin::PeopleHelper
  #获得人员在活动中的登录时间
  #如果人员与活动没有关系返回"人员不属于活动"
  #如果人员在活动中没有配置特殊登录时间则返回“与活动时间相同”
  #如果有特殊配置那么返回配置的时间段 :begin_time=>..,:end_time=>..
  def person_activity_time person, activity

    login_time_result = person.join_activity_time activity
    if login_time_result[:type]=='not_in_activity'
      return "人员不属于活动"
    elsif login_time_result[:type]=='no_activity_set_time'
      return "与活动时间相同"
    else
      return "由 #{login_time_result[:begin_time].to_s} 到 #{login_time_result[:end_time].to_s} "
    end
  end
end
