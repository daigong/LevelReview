#系统中需要登录操作的基类，配置了用户是否登录的过滤器
class Common::LoginSystemBaseController < ApplicationController
  before_filter :check_redirect_login_page
  helper_method :login_user, :login?
  #检查登录
  def check_redirect_login_page
    redirect_to login_url unless login?
  end
end
