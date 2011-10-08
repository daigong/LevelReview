class BaseReview::BaseReviewActivityController < ApplicationController
  def index
    @admin_review_activity = Admin::ReviewActivity.find params[:id]
  end
end
