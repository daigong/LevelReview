class Admin::SerialCodeBatchesController < Admin::BaseController
  layout 'admin/admin'
  # GET /admin/serial_code_batches
  # GET /admin/serial_code_batches.json
  def index
    @admin_serial_code_batches = Admin::SerialCodeBatch.all
    @admin_review_activity = Admin::ReviewActivity.find params[:activity_id]
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
    @admin_serial_code_batch.activity=Admin::ReviewActivity.find params[:activity_id];
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
    @admin_serial_code_batch.build_time=DateTime.now
    @admin_serial_code_batch.save
    #活动生成数量
    build_count = params[:build_count];
    @admin_serial_code_batch.build_serial_code build_count
    redirect_to build_activity_codes_index_admin_review_activity_url(@admin_serial_code_batch.activity), notice=>'Serial code batch was successfully created.'
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
      format.html { redirect_to admin_serial_code_batches_url(:activity_id=>params[:activity_id]) }
      format.json { head :ok }
    end
  end
end
