#参与活动的基类
class Common::JoinActivityBaseController < ApplicationController
  before_filter :check_redirect_login_page, :check_login_time_redirect_user_zone_index

  #检查登录
  def check_redirect_login_page
    redirect_to login_url unless login?
  end

  #检查登录时间
  def check_login_time_redirect_user_zone_index
    redirect_to user_zone_index_url unless login_user.now_can_join_activity? curr_activity
  end

  #获得当前活动,利用URL路径中的活动
  def curr_activity
    Admin::ReviewActivity.find params[:activity_id]
  end
end
