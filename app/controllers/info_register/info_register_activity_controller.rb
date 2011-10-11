class InfoRegister::InfoRegisterActivityController < Admin::BaseController
  layout 'admin/admin'
  #活动维护页面首页
  def index
    @admin_review_activity = Admin::ReviewActivity.find params[:id]
  end
end
