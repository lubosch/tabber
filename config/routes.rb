Tabber::Application.routes.draw do

  resources :song do
  end

  resources :video do
    collection do
      post :parse_youtube
    end
  end

  resources :log_software do

  end

    resources :software do
    collection do
      get :last
    end
  end

  resources :user_sessions


  namespace :user do
    #collection do
    post :update_ip
    #end
  end

  root to: 'static_pages#home'
  get '/about-me' => 'static_pages#about_me', :as => 'about_me'
  get '/my-activity' => 'activities#show', :as => 'activity_show'

  get '/activities-logging' => 'static_pages#activity_logging', :as => 'activity_logging'
  get '/we-help' => 'static_pages#we_help', :as => 'we_help'
  get '/actual-state' => 'static_pages#actual_state', :as => 'actual_state'
  get '/security' => 'static_pages#security', :as => 'security'
  get '/installation' => 'static_pages#installation', :as => 'installation'
  get '/installation-detailed' => 'static_pages#installation_detailed', :as => 'installation_detailed'
  get '/to-fix' => 'static_pages#to_fix', :as => 'to_fix'
  get '/feedback' => 'static_pages#feedback', :as => 'feedback'


  get '/log-out' => 'user_sessions#destroy', :as => 'logout'


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
  # just remember to delete public/home.html.erb.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
