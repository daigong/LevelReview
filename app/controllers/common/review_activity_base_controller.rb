class Common::ReviewActivityBaseController < Admin::BaseController
  layout 'admin/admin'
  def index
    @admin_review_activity = Admin::ReviewActivity.find params[:id]
  end
end
