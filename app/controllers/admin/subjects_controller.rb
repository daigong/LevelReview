class Admin::SubjectsController < ApplicationController
  # GET /admin/subjects
  # GET /admin/subjects.json
  def index
    @admin_subjects = Admin::Subject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_subjects }
    end
  end

  # GET /admin/subjects/1
  # GET /admin/subjects/1.json
  def show
    @admin_subject = Admin::Subject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_subject }
    end
  end

  # GET /admin/subjects/new
  # GET /admin/subjects/new.json
  def new
    @admin_subject = Admin::Subject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_subject }
    end
  end

  # GET /admin/subjects/1/edit
  def edit
    @admin_subject = Admin::Subject.find(params[:id])
  end

  # POST /admin/subjects
  # POST /admin/subjects.json
  def create
    @admin_subject = Admin::Subject.new(params[:admin_subject])

    respond_to do |format|
      if @admin_subject.save
        format.html { redirect_to @admin_subject, notice: 'Subject was successfully created.' }
        format.json { render json: @admin_subject, status: :created, location: @admin_subject }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/subjects/1
  # PUT /admin/subjects/1.json
  def update
    @admin_subject = Admin::Subject.find(params[:id])

    respond_to do |format|
      if @admin_subject.update_attributes(params[:admin_subject])
        format.html { redirect_to @admin_subject, notice: 'Subject was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/subjects/1
  # DELETE /admin/subjects/1.json
  def destroy
    @admin_subject = Admin::Subject.find(params[:id])
    @admin_subject.destroy

    respond_to do |format|
      format.html { redirect_to admin_subjects_url }
      format.json { head :ok }
    end
  end
end
