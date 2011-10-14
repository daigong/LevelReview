#encoding=utf-8
class DepartmentReview::InfoReviewController < DepartmentReview::BaseController
  #部门审核资料列表
  def index
    @search = Admin::Person.search params[:search]
    @people = curr_activity.pre_activity_pass_people(@search).paginate(:page => params[:page]);
  end
  
end
