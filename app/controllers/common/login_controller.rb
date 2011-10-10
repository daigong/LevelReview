#encoding=utf-8
class Common::LoginController < ApplicationController
  #跳转到登录页面
  def login
    @person = Admin::Person.new
  end

  #处理登录请求
  def login_commit
    admin_person = params[:admin_person];
    login_person = Admin::Person.find_by_user_name_and_password(admin_person[:user_name], admin_person[:password]);
    if login_person.nil?
      notice[:message]='用户名密码不匹配！'
      redirect_to :back
    else
      session[:login_user_id]=login_person.id
      if 'admin'==login_person.user_name
        #管理员页面
        redirect_to :controller => 'admin/admin_index', :action => :index
      else
        #用户页面
        redirect_to :controller => 'user_zone/zone_index', :action => :index
      end
    end
  end
end
