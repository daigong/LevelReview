class Admin::ReviewActivitiesController < ApplicationController


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
  end

  #配置人员筛选列表
  def configure_people_search_index
    params[:search] = {} if params[:search].nil?
    @search = Admin::Person.search params[:search]
    #查找当前还没在该活动内的人员
    @people = @search.
        #子查询查询到已经参加到活动的人的id
        where('admin_people.id not in ( select admin_people.id from admin_people inner join admin_person_activity_relations relation on relation.person_id = admin_people.id where relation.activity_id = ? )', params[:activity_id]).
        paginate(:page => params[:page]);
  end

  #配置人员提交处理
  def configure_people_commit

  end


  #配置人员取消处理
  def configure_people_cancel

  end

  #设置组长 or 取消组长
  def configure_person_leader

  end

  #配置活动内人员特殊登录时间 begin
  def configure_person_login_time

  end
  #配置该活动人员 end
end
