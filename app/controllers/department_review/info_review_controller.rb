#encoding=utf-8
class DepartmentReview::InfoReviewController < DepartmentReview::BaseController
  #部门审核资料列表
  def index
    @search = Admin::Person.search params[:search]
    add_department_search = @search.where({:department_id.eq=>login_user.department_id})
    @people = curr_activity.pre_activity_pass_people(add_department_search).paginate(:page => params[:page]);
  end

  #审核人员信息
  def review_person_register_info
    relation = Admin::PersonActivityRelation.find params[:relation_id]
    relation.review_time=DateTime.now
    relation.update_attributes params[:admin_person_activity_relation]
    flash[:notice] = '审核成功！'
    redirect_to :back
  end

  def confirm_person_register_info
    relation = Admin::PersonActivityRelation.find params[:relation_id]
    relation.confirmor_id = login_user.id
    relation.confirm_time = DateTime.now
    relation.confirm_result="pass"
    relation.save
    redirect_to :back
  end
end
