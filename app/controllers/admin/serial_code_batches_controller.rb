class Admin::SerialCodeBatchesController < ApplicationController
  # GET /admin/serial_code_batches
  # GET /admin/serial_code_batches.json
  def index
    @admin_serial_code_batches = Admin::SerialCodeBatch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_serial_code_batches }
    end
  end

  # GET /admin/serial_code_batches/1
  # GET /admin/serial_code_batches/1.json
  def show
    @admin_serial_code_batch = Admin::SerialCodeBatch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_serial_code_batch }
    end
  end

  # GET /admin/serial_code_batches/new
  # GET /admin/serial_code_batches/new.json
  def new
    @admin_serial_code_batch = Admin::SerialCodeBatch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_serial_code_batch }
    end
  end

  # GET /admin/serial_code_batches/1/edit
  def edit
    @admin_serial_code_batch = Admin::SerialCodeBatch.find(params[:id])
  end

  # POST /admin/serial_code_batches
  # POST /admin/serial_code_batches.json
  def create
    @admin_serial_code_batch = Admin::SerialCodeBatch.new(params[:admin_serial_code_batch])

    respond_to do |format|
      if @admin_serial_code_batch.save
        format.html { redirect_to @admin_serial_code_batch, notice: 'Serial code batch was successfully created.' }
        format.json { render json: @admin_serial_code_batch, status: :created, location: @admin_serial_code_batch }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_serial_code_batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/serial_code_batches/1
  # PUT /admin/serial_code_batches/1.json
  def update
    @admin_serial_code_batch = Admin::SerialCodeBatch.find(params[:id])

    respond_to do |format|
      if @admin_serial_code_batch.update_attributes(params[:admin_serial_code_batch])
        format.html { redirect_to @admin_serial_code_batch, notice: 'Serial code batch was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_serial_code_batch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/serial_code_batches/1
  # DELETE /admin/serial_code_batches/1.json
  def destroy
    @admin_serial_code_batch = Admin::SerialCodeBatch.find(params[:id])
    @admin_serial_code_batch.destroy

    respond_to do |format|
      format.html { redirect_to admin_serial_code_batches_url }
      format.json { head :ok }
    end
  end
end
