#系统中需要登录操作的基类，配置了用户是否登录的过滤器
class Common::LoginSystemBaseController < ApplicationController
  before_filter :check_redirect_login_page
  helper_method :login_user, :login?
  #检查登录
  def check_redirect_login_page
    redirect_to login_url unless login?
  end
  #获得登录用户
  def login_user
    login_user_token = session[:login_user_token]
    return false if login_user_token.nil?
    Admin::Person.find login_user_token
  end

  #用户是否登录
  def login?
    unless login_user
      return false
    else
      return true
    end
  end
end
