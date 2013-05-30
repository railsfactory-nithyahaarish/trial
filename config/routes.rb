MyApp1::Application.routes.draw do


  resources :payments


  resources :orders


  resources :line_items


  resources :carts
  
  resources :products do 
    get "search_results", :on => :collection
  end

  get "store/index"
  get "products/search"
  post "products/search"
  get "store/category"
 

  match '/auth/facebook/callback' => 'users#facebook_login'
  match '/auth/twitter/callback' => 'users#twitter_login'
  
  match 'confirm_payment' => 'payments#confirm'
  get "user_dashboard/index"

  get "view_page/index"
 
  post "users/user_tweet"
  

 get "admin/index"
 controller :sessions do
  get 'login' => :new

  post 'login' => :create

  delete 'logout' => :destroy
 end 

  resources :users do
   put 'upload', :on => :collection
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
 root :to => 'store#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
