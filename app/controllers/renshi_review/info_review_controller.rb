#encoding=utf-8
class RenshiReview::InfoReviewController <RenshiReview::BaseController
  #审核资料列表
  def index
    @search = Admin::Person.search params[:search]
    @people = curr_activity.pre_activity_pass_people(@search).
        paginate(:page => params[:page]);
  end

  #审核人员信息
  def review_person_register_info
    relation = Admin::PersonActivityRelation.find params[:relation_id]
    relation.person.review_activity_by(login_user, curr_activity, params[:admin_person_activity_relation])
    flash[:notice] = '审核成功！'
    redirect_to :back
  end

  #组长确认，并把结果记录在活动结果中
  def confirm_person_register_info
    person = Admin::Person.find params[:person_id]
    relation = person.confirm_activity_by(login_user, curr_activity)
    relation.activity_result=relation.review_result
    relation.save
    flash[:notice] = '确认审核成功！'
    redirect_to :back
  end
end
