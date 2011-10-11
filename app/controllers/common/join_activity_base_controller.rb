#参与活动的基类
class Common::JoinActivityBaseController < ApplicationController
  before_filter :check_redirect_login_page
  #检查登录器
  def check_redirect_login_page
    redirect_to login_url unless login?
  end
end
