#参与活动的基类
#配置了活动的时间检查
class Common::JoinActivityBaseController < Common::LoginSystemBaseController
  before_filter :check_login_time_redirect_user_zone_index

  helper_method :curr_activity

  #检查登录时间
  def check_login_time_redirect_user_zone_index
    redirect_to user_zone_index_url unless login_user.now_can_join_activity? curr_activity
  end

  #获得当前活动,利用URL路径中的活动
  def curr_activity
    Admin::ReviewActivity.find params[:activity_id]
  end
end
