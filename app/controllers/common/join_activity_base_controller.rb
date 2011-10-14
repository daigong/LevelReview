#参与活动的基类
#配置了活动的时间检查
class Common::JoinActivityBaseController < Common::LoginSystemBaseController
  before_filter :check_login_time_redirect_user_zone_index

  helper_method :curr_activity, :leader_login?, :person_info_confirm?, :person_info_review?

  #检查登录时间
  def check_login_time_redirect_user_zone_index
    redirect_to user_zone_index_url unless login_user.now_can_join_activity? curr_activity
  end

  #获得当前活动,利用URL路径中的活动
  def curr_activity
    Admin::ReviewActivity.find params[:activity_id]
  end

  #判定当前是否的组长登录
  def leader_login?
    relation = Admin::PersonActivityRelation.find_by_person_id_and_activity_id login_user.id, curr_activity.id
    return !relation.nil?&&relation.is_leader
  end

  #人员信息是否被组长确认
  def person_info_confirm? activity, person
    Admin::PersonActivityRelation.confirm? activity, person
  end

  #人员信息是否被审核
  def person_info_review? activity, person
    Admin::PersonActivityRelation.review? activity, person
  end
end
