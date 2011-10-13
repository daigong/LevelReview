#encoding=utf-8
#基本信息录入
class InfoRegister::BaseInfosController < InfoRegister::BaseController

  def new
    if login_user.base_info.nil?
      #如果还没有填写过基本信息,new一个,save进去,然后以后的都是修改操作
      @info_register_base_info = InfoRegister::BaseInfo.new
      @info_register_base_info.owner=login_user
      @info_register_base_info.save!(:validate => false)
    else
      @info_register_base_info = login_user.base_info
    end

    redirect_to edit_info_register_base_info_path(curr_activity, @info_register_base_info);
  end

  def edit
    @info_register_base_info = login_user.base_info
    @admin_person = login_user
  end

  def update
    #更新人员基本信息 个人姓名、手机、邮件
    @info_register_base_info = InfoRegister::BaseInfo.find(params[:id])
    @info_register_base_info.owner.update_attributes(params[:person], :validate=>false)
    if @info_register_base_info.update_attributes(params[:info_register_base_info])
      flash[:notice]='填写成功'
    end
    redirect_to edit_info_register_base_info_path(curr_activity, @info_register_base_info);
  end

end
