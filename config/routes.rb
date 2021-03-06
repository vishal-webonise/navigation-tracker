NavigationTracker::Application.routes.draw do
  root :to => 'static_pages#home'
  match "features" => 'static_pages#feature'
  match "take_tour" => 'static_pages#take_tour'

  devise_for :users
  resources :users do
    member do
      get :admin_accessible_change
      put :admin_accessible_update
      put :update_password
    end
    collection do
      post :create_project
    end
  end
  resources :dashboard do
    collection do
      get :user_projects
      get :project_users
      post :assign_project_users, :as => :assign_project_users_from
      get :admin
    end
  end
  resources :projects do 
    member do
      get :tracking_code, :as => :tracking_code_for
      get :users, :as => :users_assigned_on
      post :assign_users, :as => :assign_users_to
      delete :unassign_user, :as => :unassign_user_from
      get :visitor_behaviour, :as => :visitor_behaviour_on
    end
  end
  resources :apis do
    collection do
      get :tracker
    end
  end
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
  # match ':controller(/:action(/:id))(.:format)'
end
