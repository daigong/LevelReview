class Admin::SerialCodesController < ApplicationController
  # GET /admin/serial_codes
  # GET /admin/serial_codes.json
  def index
    @admin_serial_codes = Admin::SerialCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_serial_codes }
    end
  end

  # GET /admin/serial_codes/1
  # GET /admin/serial_codes/1.json
  def show
    @admin_serial_code = Admin::SerialCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_serial_code }
    end
  end

  # GET /admin/serial_codes/new
  # GET /admin/serial_codes/new.json
  def new
    @admin_serial_code = Admin::SerialCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_serial_code }
    end
  end

  # GET /admin/serial_codes/1/edit
  def edit
    @admin_serial_code = Admin::SerialCode.find(params[:id])
  end

  # POST /admin/serial_codes
  # POST /admin/serial_codes.json
  def create
    @admin_serial_code = Admin::SerialCode.new(params[:admin_serial_code])

    respond_to do |format|
      if @admin_serial_code.save
        format.html { redirect_to @admin_serial_code, notice: 'Serial code was successfully created.' }
        format.json { render json: @admin_serial_code, status: :created, location: @admin_serial_code }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_serial_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/serial_codes/1
  # PUT /admin/serial_codes/1.json
  def update
    @admin_serial_code = Admin::SerialCode.find(params[:id])

    respond_to do |format|
      if @admin_serial_code.update_attributes(params[:admin_serial_code])
        format.html { redirect_to @admin_serial_code, notice: 'Serial code was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_serial_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/serial_codes/1
  # DELETE /admin/serial_codes/1.json
  def destroy
    @admin_serial_code = Admin::SerialCode.find(params[:id])
    @admin_serial_code.destroy

    respond_to do |format|
      format.html { redirect_to admin_serial_codes_url }
      format.json { head :ok }
    end
  end
end
