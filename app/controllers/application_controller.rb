class ApplicationController < ActionController::Base
  protect_from_forgery

  #获得登录用户
  def login_user
    login_user_token = session[:login_user_token]
    return false if login_user_token.nil?
    Admin::Person.find login_user_token
  end

  #用户是否登录
  def login?
    return !login_user.nil?
  end

end
