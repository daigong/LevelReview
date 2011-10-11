#encoding=utf-8
module UserZone::ZoneIndexHelper
  #传入活动，生成进入活动的链接
  #需要在routes.rb中配置每个活动的index
  def link_to_activity_index activity
    #需要在routes.rb中配置as=>index
    #例子：
    #   namespace :department_review do
    #    scope :path=>':activity_id' do
    #      #活动首页
    #      get 'index' => 'ReviewIndex#index', :as=>:index #:as 需要配置,url=>department_review_index_url
    #    end
    #   end
    link_to_method = "#{activity.activity_type}_index_url"
    if respond_to? link_to_method
      link_to activity.name, send(link_to_method,activity)
    else
      "没有合适的链接，请核实."
    end
  end
end
