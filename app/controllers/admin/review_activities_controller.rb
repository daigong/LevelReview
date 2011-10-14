class Admin::ReviewActivitiesController < Admin::BaseController

  #默认使用admin模板
  layout 'admin/admin'

  #通过活动类型决定用户到那个页面去定制活动信息
  #定制活动需要配置 /admin/activity_type/ url路径
  def show
    @admin_review_activity = Admin::ReviewActivity.find(params[:id])
    redirect_to "/admin/#{@admin_review_activity.activity_type}/#{params[:id]}/"
  end


  # PUT /admin/review_activities/1
  # PUT /admin/review_activities/1.json
  def update
    @admin_review_activity = Admin::ReviewActivity.find(params[:id])

    respond_to do |format|
      if @admin_review_activity.update_attributes(params[:admin_review_activity])
        format.html { redirect_to @admin_review_activity, notice: 'Review activity was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_review_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  #配置该活动人员 begin
  #配置该活动人员页面跳转
  def configure_people_index
    @admin_review_activity = Admin::ReviewActivity.find(params[:id])
    params[:search] = {} if params[:search].nil?
    @search = Admin::Person.search params[:search]
    #子查询查询到已经参加到活动的人的id
    #配置人员模块差分：对info_register来说，选择人员在关系表中role_type是：info_register，而其他模块为review
    if  @admin_review_activity.activity_type=="info_register"
      search_type = 'info_register'
    else
      search_type = 'review'
    end
    @people = @search.
        joins(:person_activity_relations).
        where({:person_activity_relations=>{:activity_id.eq=>@admin_review_activity.id, :role_type.eq=>search_type}}).
        order('admin_people.department_id asc').
        paginate(:page => params[:page]);
  end

  #配置人员筛选列表
  def configure_people_search_index
    @admin_review_activity = Admin::ReviewActivity.find(params[:id])
    params[:search] = {} if params[:search].nil?
    @search = Admin::Person.search params[:search]
    #查找当前还没在该活动内的人员
    @people = @search.
        order('admin_people.department_id asc').
        paginate(:page => params[:page]);
    @people_in_activity = @admin_review_activity.people_in_activity
  end

  #配置人员提交处理
  def configure_people_commit
    admin_review_activity = Admin::ReviewActivity.find(params[:id])
    ids = params[:ids].split(',');
    ids.each do |id|
      person = Admin::Person.find id
      person.join_activity admin_review_activity
    end
    respond_to do |format|
      format.json { render :json => ids }
    end
  end


  #配置人员取消处理
  def configure_people_cancel
    admin_review_activity = Admin::ReviewActivity.find(params[:id])
    ids = params[:ids].split(',');
    ids.each do |id|
      person = Admin::Person.find id
      person.quit_activity admin_review_activity
    end
    respond_to do |format|
      format.json { render :json => ids }
    end
  end

  #配置活动内人员特殊登录时间 begin
  def configure_person_login_time
    #时间格式：YYYY-mm-dd 23:59:59
    begin_time = DateTime.strptime(params[:begin_time], "%Y-%m-%d %H:%M:%S")
    end_time =DateTime.strptime(params[:end_time], "%Y-%m-%d %H:%M:%S")
    admin_review_activity = Admin::ReviewActivity.find(params[:id])
    ids = params[:ids].split(',');
    ids.each do |id|
      person = Admin::Person.find id
      person.set_join_activity_time admin_review_activity, begin_time, end_time
    end
    respond_to do |format|
      format.json { render :json => ids }
    end
  end

  #取消对用户设置的特殊登录时间
  def configure_reset_person_login_time
    admin_review_activity = Admin::ReviewActivity.find(params[:id])
    ids = params[:ids].split(',');
    ids.each do |id|
      person = Admin::Person.find id
      person.set_join_activity_time admin_review_activity, nil, nil
    end
    respond_to do |format|
      format.json { render :json => ids }
    end
  end

  #设置组长页面
  def configure_activity_leader_index
    params[:search] = {} if params[:search].nil?
    @search = Admin::Person.search params[:search]
    @admin_review_activity = Admin::ReviewActivity.find(params[:id])
    @people_in_activity = @search.
        joins(:person_activity_relations).
        where({:person_activity_relations=>{:activity_id.eq=>@admin_review_activity.id, :role_type.eq=>"review"}}).
        order('admin_people.department_id asc').
        order('admin_person_activity_relations.is_leader desc').
        paginate(:page => params[:page]);
  end

  #设置组长提交
  def configure_activity_leader_commit
    @admin_review_activity = Admin::ReviewActivity.find(params[:id])
    ids = params[:ids].split(',');
    ids.each do |id|
      person = Admin::Person.find id
      person.set_activity_leader @admin_review_activity, true
    end
    respond_to do |format|
      format.json { render :json => ids }
    end
  end

  #设置组长取消
  def configure_activity_leader_cancel
    @admin_review_activity = Admin::ReviewActivity.find(params[:id])
    ids = params[:ids].split(',');
    ids.each do |id|
      person = Admin::Person.find id
      person.set_activity_leader @admin_review_activity, false
    end
    respond_to do |format|
      format.json { render :json => ids }
    end
  end

  #配置该活动人员 end
  #配置活动序列码 begin
  #进入批量序列码生成首页
  def build_activity_codes_index
    @admin_review_activity = Admin::ReviewActivity.find(params[:id])
    @search = Admin::SerialCode.search params[:search]
    @admin_serial_codes = @search.joins(:batch).
        where(:admin_serial_code_batches=>{:activity_id.eq=>@admin_review_activity.id}).
        order('admin_serial_code_batches.build_time desc').
        order('admin_serial_codes.code desc').
        paginate(:page => params[:page]);
  end
  #配置活动序列码 end
end
