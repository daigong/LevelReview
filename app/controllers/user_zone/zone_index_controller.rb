class UserZone::ZoneIndexController < ApplicationController
  #用户空间模板
  layout 'user_zone/user_zone'
  #用户首页
  def index
    #查询出用户可以参加的活动
    @admin_person = login_user
    @activities = @admin_person.now_can_join_activities
    if @activities.size == 1
      #TODO 如果用户当前（时间控制）可以参加的活动只有一个，那么帮助客户跳转到该活动内
    end
  end
end
