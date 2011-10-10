class Admin::ReviewProjectsController < Admin::BaseController
  #默认使用admin模板
  layout 'admin/admin'
  # GET /admin/review_projects
  # GET /admin/review_projects.json
  def index
    @admin_review_projects = Admin::ReviewProject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_review_projects }
    end
  end

  # GET /admin/review_projects/1
  # GET /admin/review_projects/1.json
  def show
    @admin_review_project = Admin::ReviewProject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_review_project }
    end
  end

  # GET /admin/review_projects/new
  # GET /admin/review_projects/new.json
  def new
    @admin_review_project = Admin::ReviewProject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_review_project }
    end
  end

  # GET /admin/review_projects/1/edit
  def edit
    @admin_review_project = Admin::ReviewProject.find(params[:id])
  end

  # POST /admin/review_projects
  # POST /admin/review_projects.json
  def create
    @admin_review_project = Admin::ReviewProject.create_new_review_project(params[:admin_review_project])
    redirect_to @admin_review_project, notice: 'Review project was successfully created.'
  end

  # PUT /admin/review_projects/1
  # PUT /admin/review_projects/1.json
  def update
    @admin_review_project = Admin::ReviewProject.find(params[:id])
    respond_to do |format|
      if @admin_review_project.update_attributes(params[:admin_review_project])
        format.html { redirect_to @admin_review_project, notice: 'Review project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_review_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/review_projects/1
  # DELETE /admin/review_projects/1.json
  def destroy
    @admin_review_project = Admin::ReviewProject.find(params[:id])
    @admin_review_project.destroy

    respond_to do |format|
      format.html { redirect_to admin_review_projects_url }
      format.json { head :ok }
    end
  end
end
