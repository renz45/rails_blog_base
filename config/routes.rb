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

    root to: "posts#index", via: :get

    get "/page/:posts_page" => "posts#index", 
          as: :page

    get "/posts(/tag/:tag)(/category/:category)(/page/:page)" => "posts#search", 
          as: :posts_search, 
          defaults: {page: 1}

    get "/feed" => "posts#feed",
          as: :feed,
          defaults: {format: 'atom'}

    get "/rss" => redirect("/blog/feed")

    get "/atom" => redirect("/blog/feed")

    get "/:slug(/comment(/reply/:reply_id)(:comment_id))(/page/:page)" => "posts#show", 
          as: :post

    post "/comments/create" => "comments#create",  
          as: :comments_create
  end

  namespace :admin do
    root to: "pages#index"

    namespace :blog do
      root to: "pages#index"

      resources :posts

      get "/posts(/type/:type(/tag/:tag)(/category/:category)(/page/:page))" => "posts#search",
            as: :posts_search
      
      get "/posts(/page/:page)" => "posts#index",
            as: :posts

      post "/posts/create/preview" => "posts#create_preview",
            as: :posts_create_preview

      get "/posts/preview/:id" => "posts#show_preview",
            as: :posts_preview

      delete "/posts/trash/:id" => "posts#trash",
            as: :trash_post

      resources :comments, except: :destroy

      post "/comments/update/status" => "comments#update_status",
            as: :comment_update_status

      delete "/comments/delete" => "comments#delete",
            as: :delete_comment
      
      get "/comments/page/:page" => "comments#index",
            as: :comments_page

      get "/comments/type/:type(/page/:page)" => "comments#search",
            as: :comments_search

      resources :tags

      get "tags/page/:page" => "tags#index",
            as: :tags_page
      
      delete "/tags" => "tags#destroy"

      resources :categories

      get "categories/page/:page" => "categories#index",
            as: :categories_page
      
      delete "/categories" => "categories#destroy"
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
