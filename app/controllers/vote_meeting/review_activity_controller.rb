class VoteMeeting::ReviewActivityController < BaseReview::BaseReviewActivityController
  def index
    @admin_review_activity = Admin::ReviewActivity.find params[:id]
  end
end
