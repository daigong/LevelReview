#encoding=utf-8
class Admin::ReviewProject < ActiveRecord::Base
  #项目下的所有活动按照顺序
  def project_activities
    #现阶段都是写死的，以后需要根据模板来生成
    activities=[];
    info_register_activity = Admin::ReviewActivity.
        find_by_review_project_id_and_activity_type(self, 'info_register');
    activities<<info_register_activity
    department_review_activity = Admin::ReviewActivity
    .find_by_review_project_id_and_activity_type(self, 'department_review');
    activities<<department_review_activity
    jiaowu_review_activity = Admin::ReviewActivity.
        find_by_review_project_id_and_activity_type(self, 'jiaowu_review');
    activities<<jiaowu_review_activity
    keyan_review_activity = Admin::ReviewActivity.
        find_by_review_project_id_and_activity_type(self, 'keyan_review');
    activities<<keyan_review_activity
    renshi_review_activity = Admin::ReviewActivity.
        find_by_review_project_id_and_activity_type(self, 'renshi_review');
    activities<<renshi_review_activity
    vote_meeting_activity = Admin::ReviewActivity.
        find_by_review_project_id_and_activity_type(self, 'vote_meeting');
    activities<<vote_meeting_activity
    subject_meeting_activity = Admin::ReviewActivity.
        find_by_review_project_id_and_activity_type(self, 'subject_meeting');
    activities<<subject_meeting_activity
    return activities
  end

  #创建一个评审项目
  #新建项目需要创建项目与活动的关系
  #参评信息填写-->部门审核-->教务、科研、人事审核-->评选大会-->学科组
  def self.create_new_review_project new_project_params
    project = Admin::ReviewProject.new new_project_params
    project.save
    #活动创建 begin
    #活动1.参评人信息录入 activity_type:info_register
    info_register_activity = Admin::ReviewActivity.new
    info_register_activity.review_project=project
    info_register_activity.name="参评资料录入";
    info_register_activity.begin_time=DateTime.now
    info_register_activity.end_time=DateTime.now + 10.day
    info_register_activity.activity_type="info_register"
    info_register_activity.save
    #活动2.部门审核 activity_type:department_review
    department_review_activity = Admin::ReviewActivity.new
    department_review_activity.review_project=project
    department_review_activity.name="部门审核";
    department_review_activity.begin_time=DateTime.now
    department_review_activity.end_time=DateTime.now
    department_review_activity.activity_type="department_review"
    department_review_activity.save
    #活动3.教务处审核
    jiaowu_review_activity = Admin::ReviewActivity.new
    jiaowu_review_activity.review_project=project
    jiaowu_review_activity.name="教务处审核";
    jiaowu_review_activity.begin_time=DateTime.now
    jiaowu_review_activity.end_time=DateTime.now
    jiaowu_review_activity.activity_type="jiaowu_review"
    jiaowu_review_activity.save
    #活动4.科研处审核
    keyan_review_activity = Admin::ReviewActivity.new
    keyan_review_activity.review_project=project
    keyan_review_activity.name="科研处审核";
    keyan_review_activity.begin_time=DateTime.now
    keyan_review_activity.end_time=DateTime.now
    keyan_review_activity.activity_type="keyan_review"
    keyan_review_activity.save
    #活动4.人事处审核
    renshi_review_activity = Admin::ReviewActivity.new
    renshi_review_activity.review_project=project
    renshi_review_activity.name="人事处审核";
    renshi_review_activity.begin_time=DateTime.now
    renshi_review_activity.end_time=DateTime.now
    renshi_review_activity.activity_type="renshi_review"
    renshi_review_activity.save
    #活动5.评委会
    vote_meeting_activity = Admin::ReviewActivity.new
    vote_meeting_activity.review_project=project
    vote_meeting_activity.name="评委会";
    vote_meeting_activity.begin_time=DateTime.now
    vote_meeting_activity.end_time=DateTime.now
    vote_meeting_activity.activity_type="vote_meeting"
    vote_meeting_activity.save
    #活动6.学科组
    subject_meeting_activity = Admin::ReviewActivity.new
    subject_meeting_activity.review_project=project
    subject_meeting_activity.name="学科组";
    subject_meeting_activity.begin_time=DateTime.now
    subject_meeting_activity.end_time=DateTime.now
    subject_meeting_activity.activity_type="subject_meeting"
    subject_meeting_activity.save
    #活动创建 end

    #建立活动之间的关系 begin
    #                        |-->教务处审核-->|
    #参评人信息录入-->部门审核-->|-->人事处审核-->|-->评委会-->学科组
    #                        |-->科研处审核-->|
    #参评人信息录入关系 没有前置任务
    info_register_activity_relation = Admin::ReviewActivityRelation.new
    info_register_activity_relation.activity=info_register_activity
    info_register_activity_relation.save
    #部门审核关系 前置任务：参评人信息录入
    department_review_activity_relation = Admin::ReviewActivityRelation.new
    department_review_activity_relation.pre_activity=info_register_activity
    department_review_activity_relation.activity=department_review_activity
    #教务处审核活动关系
    jiaowu_review_activity_relation=Admin::ReviewActivityRelation.new
    jiaowu_review_activity_relation.pre_activity=department_review_activity
    jiaowu_review_activity_relation.activity=jiaowu_review_activity
    jiaowu_review_activity_relation.save
    #人事处审核活动关系
    renshi_review_activity_relation=Admin::ReviewActivityRelation.new
    renshi_review_activity_relation.pre_activity=department_review_activity
    renshi_review_activity_relation.activity=renshi_review_activity
    renshi_review_activity_relation.save
    #科研处审核活动关系
    keyan_review_activity_relation=Admin::ReviewActivityRelation.new
    keyan_review_activity_relation.pre_activity=department_review_activity
    keyan_review_activity_relation.activity=keyan_review_activity
    keyan_review_activity_relation.save
    #评委会活动有3个关系 前置任务：3个教务、科研、人事
    #1
    vote_meeting_activity_pre_jiaowu_relation=Admin::ReviewActivityRelation.new
    vote_meeting_activity_pre_jiaowu_relation.pre_activity=jiaowu_review_activity
    vote_meeting_activity_pre_jiaowu_relation.activity=vote_meeting_activity
    vote_meeting_activity_pre_jiaowu_relation.save
    #2
    vote_meeting_activity_pre_keyan_relation=Admin::ReviewActivityRelation.new
    vote_meeting_activity_pre_keyan_relation.pre_activity=keyan_review_activity
    vote_meeting_activity_pre_keyan_relation.activity=vote_meeting_activity
    vote_meeting_activity_pre_keyan_relation.save
    #3
    vote_meeting_activity_pre_renshi_relation=Admin::ReviewActivityRelation.new
    vote_meeting_activity_pre_renshi_relation.pre_activity=renshi_review_activity
    vote_meeting_activity_pre_renshi_relation.activity=vote_meeting_activity
    vote_meeting_activity_pre_renshi_relation.save
    #学科组
    subject_meeting_activity_relation=Admin::ReviewActivityRelation.new
    subject_meeting_activity_relation.pre_activity=vote_meeting_activity
    subject_meeting_activity_relation.activity=subject_meeting_activity
    subject_meeting_activity_relation.save
    #建立活动之间的关系 end
    return project
  end
end
