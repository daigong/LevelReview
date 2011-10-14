LevelReview::Application.routes.draw do

  #首页为登录页面
  root :to=>'common/login#login', :as=>'login'
  post '/login_commit'=>'common/login#login_commit', :as=>'login_commit'
  match '/login_out'=>'common/login#login_out', :as=>'login_out'
  #用户空间
  match '/user_zone/:action'=>'user_zone/zone_index', :as=>'user_zone_index'
  #登录URL配置
  #管理配置
  namespace :admin do
    #管理员首页
    match '/user_zone/:action/'=>'admin_index'
    #相关资源配置
    resources :review_projects
    resources :people
    resources :serial_codes do
      collection do
        post 'destroy_all'
      end
    end
    resources :serial_code_batches
    resources :departments
    resources :subjects
    resources :review_activities do
      member do
        #配置人员
        get 'configure_people_index'
        get 'configure_people_search_index'
        post 'configure_people_commit'
        post 'configure_people_cancel'
        post 'configure_person_leader'
        #配置人员登录时间
        post 'configure_person_login_time'
        post 'configure_reset_person_login_time'
        #设置组长
        get 'configure_activity_leader_index'
        post 'configure_activity_leader_commit'
        post 'configure_activity_leader_cancel'
        #生成批次序列码
        get 'build_activity_codes_index'
      end
    end
  end
  #活动--参评人信息录入配置 begin
  namespace :admin do
    match 'info_register/:id/' => 'info_register/InfoRegisterActivity#index'
    match 'info_register/:id/:action/' => 'info_register/InfoRegisterActivity'
  end

  namespace :info_register do
    #带有活动id的
    scope :path=>':activity_id' do
      #跳转到信息录入首页
      get 'index' => 'InfoRegisterIndex#index', :as=>:index
      #参评人信息显示
      get 'info_show'=>'InfoShow#show_person_register_info',:as=>:info_show
      #人员基本信息
      resources :base_infos
      resources :articles
    end
  end
  #活动--参评人信息录入配置 end
  #活动--部门审核 begin
  namespace :admin do
    match 'department_review/:id/' => 'department_review/ReviewActivity#index'
  end

  namespace :department_review do
    scope :path=>':activity_id' do
      #活动首页
      get 'index' => 'ReviewIndex#index', :as=>:index
      #信息审阅
      get 'info_review/index'=>'InfoReview#index', :as=>:info_review_index
      #参评人信息显示
      get 'info_show/:person_id'=>'InfoShow#show_person_register_info',:as=>:info_show
      #审核参评人信息
      put 'info_review/:relation_id'=>'InfoReview#review_person_register_info',:as=>:info_review
    end
  end
  #活动--部门审核 end
  #活动--教务审核 begin
  namespace :admin do
    match 'jiaowu_review/:id/' => 'jiaowu_review/ReviewActivity#index'
  end

  namespace :jiaowu_review do
    scope :path=>':activity_id' do
      #活动首页
      get 'index' => 'ReviewIndex#index', :as=>:index
    end
  end
  #活动--教务审核 end

  #活动--科研审核 begin
  namespace :admin do
    match 'keyan_review/:id/' => 'keyan_review/ReviewActivity#index'
  end

  namespace :keyan_review do
    scope :path=>':activity_id' do
      #活动首页
      get 'index' => 'ReviewIndex#index', :as=>:index
    end
  end
  #活动--科研审核 end
  #活动--人事审核 begin
  namespace :admin do
    match 'renshi_review/:id/' => 'renshi_review/ReviewActivity#index'
  end

  namespace :renshi_review do
    scope :path=>':activity_id' do
      #活动首页
      get 'index' => 'ReviewIndex#index', :as=>:index
    end
  end
  #活动--人事审核 end
  #活动--评委会 begin
  namespace :admin do
    match 'vote_meeting/:id/' => 'vote_meeting/ReviewActivity#index'
  end

  namespace :vote_meeting do
    scope :path=>':activity_id' do
      #活动首页
      get 'index' => 'VoteMeetingIndex#index', :as=>:index
    end
  end
  #活动--评委会 end
  #活动--学科组 begin
  namespace :admin do
    match 'subject_meeting/:id/' => 'subject_meeting/ReviewActivity#index'
  end

  namespace :subject_meeting do
    scope :path=>':activity_id' do
      #活动首页
      get 'index' => 'SubjectMeetingIndex#index', :as=>:index
    end
  end
  #活动--学科组 end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
