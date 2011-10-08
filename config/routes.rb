LevelReview::Application.routes.draw do
  namespace :admin do
    resources :people
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
      end
    end
    resources :review_projects
  end
  #活动--参评人信息录入配置 begin
  namespace :admin do
    match 'info_register/:id/' => 'info_register/InfoRegisterActivity#index'
    match 'info_register/:id/:action/' => 'info_register/InfoRegisterActivity'
  end

  namespace :info_register do

  end
  #活动--参评人信息录入配置 end
  #活动--部门审核 begin
  namespace :admin do
    match 'department_review/:id/' => 'department_review/ReviewActivity#index'
  end

  namespace :department_review do

  end
  #活动--部门审核 end
  #活动--教务审核 begin
  namespace :admin do
    match 'jiaowu_review/:id/' => 'jiaowu_review/ReviewActivity#index'
  end

  namespace :jiaowu_review do

  end
  #活动--教务审核 end

  #活动--科研审核 begin
  namespace :admin do
    match 'keyan_review/:id/' => 'keyan_review/ReviewActivity#index'
  end

  namespace :keyan_review do

  end
  #活动--科研审核 end
  #活动--人事审核 begin
  namespace :admin do
    match 'renshi_review/:id/' => 'renshi_review/ReviewActivity#index'
  end

  namespace :renshi_review do

  end
  #活动--人事审核 end
  #活动--评委会 begin
  namespace :admin do
    match 'vote_meeting/:id/' => 'vote_meeting/ReviewActivity#index'
  end

  namespace :vote_meeting do

  end
  #活动--评委会 end
  #活动--学科组 begin
  namespace :admin do
    match 'subject_meeting/:id/' => 'subject_meeting/ReviewActivity#index'
  end

  namespace :subject_meeting do

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
