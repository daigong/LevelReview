class Admin::SerialCodesController < ApplicationController
  #批量删除序列号
  def destroy_all
    ids = params[:ids].split(",");
    ids.each do |id|
      serial_code = Admin::SerialCode.find id
      serial_code.destroy
    end
    render :json => ids
  end
end
