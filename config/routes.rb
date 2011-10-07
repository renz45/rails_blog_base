BlogBase::Application.routes.draw do
  devise_for :users, 
             path_names: {sign_up: "register"} # defaults the sign_up path to use register instead

  root to: "pages#home", 
       via: :get

  # uncomment after the blog is complete
  #match "/services", to: "pages#services"
  #match "/services/personalchef", to: "pages#personal_chef"
  #match "/services/teambuilding", to: "pages#team_building"
  #match "/services/cookingclasses", to: "pages#cooking_classes" 

  namespace :blog do

    root to: "posts#index", 
         via: :get

    match "/page/:posts_page", 
          to: "posts#index", 
          as: :page, 
          via: :get

    match "category/:category_id/page/:page", 
          to: "posts#search", 
          as: :category_search, 
          defaults: {page: 1}, 
          via: :get

    match "tag/:tag_id/page/:page", 
          to: "posts#search", 
          as: :tag_search, 
          defaults: {page: 1}, 
          via: :get

    match "/category/:category_id/tag/:tag_id/page/:page", 
          to: "posts#search", 
          as: :category_tag_search, 
          defaults: {page: 1}, 
          via: :get

    match "/tag/:tag_id/category/:category_id/page/:page", 
          to: "posts#search", 
          as: :tag_category_search, 
          defaults: {page: 1}, 
          via: :get

    match "/:slug", 
          to: "posts#show", 
          as: :post, 
          via: :get

    match "/:slug/page/:page",
          to: "posts#show",  
          as: :post_page, 
          via: :get

    match "/:id/comment/:comment_id", 
          to: "posts#show", 
          as: :comment, 
          via: :get

    match "/:slug/comment/reply/:reply_id", 
          to: "posts#show", 
          as: :comment_reply, 
          via: :get

    match "/comments/create",
          to: "comments#create",  
          as: :comments_create, 
          via: :post
  end

  namespace :admin do
    root to: "pages#index"

    namespace :blog do
      root to: "pages#index"
      resources :posts
      resources :comments
    end

    namespace :settings do
      root to: "pages#index"
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
  # match ':controller(/:action(/:id(.:format)))'
end
