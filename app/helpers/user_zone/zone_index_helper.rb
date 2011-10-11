#encoding=utf-8
module UserZone::ZoneIndexHelper
  #传入活动，生成进入活动的链接
  #需要在routes.rb中配置每个活动的index
  def link_to_activity_index activity
    case activity.activity_type
      when 'info_register'
        link_to "参评人信息录入", info_register_index_url(activity)
      when 'department_review'
        link_to "部门审核", department_review_index_url(activity)
      when 'jiaowu_review'
        link_to "教务处审核", jiaowu_review_index_url(activity)
      when 'keyan_review'
        link_to "科研处审核", keyan_review_index_url(activity)
      when 'renshi_review'
        link_to "人事处审核", renshi_review_index_url(activity)
      when 'vote_meeting'
        link_to "评委会", vote_meeting_index_url(activity)
      when 'subject_meeting'
        link_to "学科组", subject_meeting_index_url(activity)
      else
        "没有合适的链接，请核实."
    end
  end
end
