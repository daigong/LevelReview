class InfoRegister::InfoShowController < InfoRegister::BaseController
  #显示人员录入的参评信息
  def show_person_register_info
    @person = login_user
  end
end
