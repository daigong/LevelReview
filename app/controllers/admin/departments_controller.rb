class Admin::DepartmentsController < Admin::BaseController
  
  #默认使用admin模板
  layout 'admin/admin'

  # GET /admin/departments
  # GET /admin/departments.json
  def index
    @admin_departments = Admin::Department.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_departments }
    end
  end

  # GET /admin/departments/1
  # GET /admin/departments/1.json
  def show
    @admin_department = Admin::Department.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_department }
    end
  end

  # GET /admin/departments/new
  # GET /admin/departments/new.json
  def new
    @admin_department = Admin::Department.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_department }
    end
  end

  # GET /admin/departments/1/edit
  def edit
    @admin_department = Admin::Department.find(params[:id])
  end

  # POST /admin/departments
  # POST /admin/departments.json
  def create
    @admin_department = Admin::Department.new(params[:admin_department])

    respond_to do |format|
      if @admin_department.save
        format.html { redirect_to @admin_department, notice: 'Department was successfully created.' }
        format.json { render json: @admin_department, status: :created, location: @admin_department }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/departments/1
  # PUT /admin/departments/1.json
  def update
    @admin_department = Admin::Department.find(params[:id])

    respond_to do |format|
      if @admin_department.update_attributes(params[:admin_department])
        format.html { redirect_to @admin_department, notice: 'Department was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/departments/1
  # DELETE /admin/departments/1.json
  def destroy
    @admin_department = Admin::Department.find(params[:id])
    @admin_department.destroy

    respond_to do |format|
      format.html { redirect_to admin_departments_url }
      format.json { head :ok }
    end
  end
end
