class Admin::BaseController < ApplicationController

  before_filter :check_redirect_login_page

  def check_redirect_login_page
    redirect_to login_url unless check_admin_login?
  end

  #检查是否是管理员用户
  def check_admin_login?
    admin_user = login_user
    return false if admin_user.nil?||!admin_user
    if  Admin::BaseController.admin_user_names.include? admin_user.user_name
      return true
    else
      return false
    end
  end

  #获得管理员用户名
  def self.admin_user_names
    ["admin"]
  end
end
