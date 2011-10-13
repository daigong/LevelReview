class DepartmentReview::InfoShowController < DepartmentReview::BaseController
  #显示人员录入的参评信息
  def show_person_register_info
    @person = Admin::Person.find params[:person_id]
  end
end
