class Admin::BaseController < ApplicationController

  before_filter :check_admin_login?
  #检查是否是管理员用户
  def check_admin_login?
    admin_user = login_user
    return false if admin_user.nil?
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
