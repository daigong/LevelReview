class InfoRegister::BaseInfosController < InfoRegister::BaseController

  # GET /info_register/base_infos/1
  # GET /info_register/base_infos/1.json
  def show
    @info_register_base_info = InfoRegister::BaseInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @info_register_base_info }
    end
  end

  # GET /info_register/base_infos/1/edit
  def edit
    @info_register_base_info = InfoRegister::BaseInfo.find(params[:id])
  end

  # PUT /info_register/base_infos/1
  # PUT /info_register/base_infos/1.json
  def update
    @info_register_base_info = InfoRegister::BaseInfo.find(params[:id])

    respond_to do |format|
      if @info_register_base_info.update_attributes(params[:info_register_base_info])
        format.html { redirect_to @info_register_base_info, notice: 'Base info was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @info_register_base_info.errors, status: :unprocessable_entity }
      end
    end
  end
end
