#encoding=utf-8
class DepartmentReview::InfoShowController < DepartmentReview::BaseController
  #显示人员录入的参评信息
  def show_person_register_info
    @person = Admin::Person.find params[:person_id]
    @person_activity_relation = Admin::PersonActivityRelation.find_by_activity_id_and_person_id @person.id, curr_activity.id
    #如果@person_activity_relation=nil 需要检查人员是否参加了上一个活动，
    #如果参与了新增一个role_type='info_register'与活动的关系
    if @person_activity_relation.nil?
      @person_activity_relation = @person.join_activity_as_info_register_role_type curr_activity
      unless @person_activity_relation
        flash[:notice] = '该人员没有参与参评活动，请确认！'
        redirect_to department_review_info_review_index_url(curr_activity)
      end
    end
  end

end
