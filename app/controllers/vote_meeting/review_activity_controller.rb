class VoteMeeting::ReviewActivityController < Common::ReviewActivityBaseController
  def index
    @admin_review_activity = Admin::ReviewActivity.find params[:id]
  end
end
