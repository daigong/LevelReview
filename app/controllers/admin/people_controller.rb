class Admin::PeopleController < ApplicationController
  #默认使用admin模板
  layout 'admin/admin'
  # GET /admin/people
  # GET /admin/people.json
  def index
    @admin_people = Admin::Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_people }
    end
  end

  # GET /admin/people/1
  # GET /admin/people/1.json
  def show
    @admin_person = Admin::Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_person }
    end
  end

  # GET /admin/people/new
  # GET /admin/people/new.json
  def new
    @admin_person = Admin::Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_person }
    end
  end

  # GET /admin/people/1/edit
  def edit
    @admin_person = Admin::Person.find(params[:id])
  end

  # POST /admin/people
  # POST /admin/people.json
  def create
    @admin_person = Admin::Person.new(params[:admin_person])

    respond_to do |format|
      if @admin_person.save
        format.html { redirect_to @admin_person, notice: 'Person was successfully created.' }
        format.json { render json: @admin_person, status: :created, location: @admin_person }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/people/1
  # PUT /admin/people/1.json
  def update
    @admin_person = Admin::Person.find(params[:id])

    respond_to do |format|
      if @admin_person.update_attributes(params[:admin_person])
        format.html { redirect_to @admin_person, notice: 'Person was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/people/1
  # DELETE /admin/people/1.json
  def destroy
    @admin_person = Admin::Person.find(params[:id])
    @admin_person.destroy

    respond_to do |format|
      format.html { redirect_to admin_people_url }
      format.json { head :ok }
    end
  end
end
