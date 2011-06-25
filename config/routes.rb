SimpleBlog::Application.routes.draw do
  
  get "comments/index"
  get "comments/show"
  match "set_status" => 'comments#set_status'

  controller :users do
    get "staff/users"            => :index,  :as => "users"
    post"staff/users/"           => :manage, :as => "users"
    get "staff/users/new"        => :manage, :as => "new_user"
    get "staff/users/manage/:id" => :manage, :as => "users_manage"
    get "staff/users/:id"        => :manage, :as => "edit_user"
    get "staff/users/:id"        => :index,  :as => "user"
    put "staff/users/:id"        => :manage, :as => "update_user"    
    delete "staff/users/:id"     => :manage, :as => "user_del" 
  end

#  resources :categories
  controller :categories do
    get "staff/categories"           => :index,   :as => "categories"
    post"staff/categories"           => :create,  :as => "categories"
    get "staff/categories/new"       => :index,   :as => "new_category"
    get "staff/categories/:id"       => :index,   :as => "edit_category"
    get "staff/categories/:id"       => :index,   :as => "category"
    put "staff/categories/:id"       => :update,  :as => "update_category"    
    delete "staff/categories/:id"    => :destroy, :as => "del_category" 
  end
 
#    categories GET    /categories(.:format)          {:action=>"index", :controller=>"categories"}
#               POST   /categories(.:format)          {:action=>"create", :controller=>"categories"}
#  new_category GET    /categories/new(.:format)      {:action=>"new", :controller=>"categories"}
# edit_category GET    /categories/:id/edit(.:format) {:action=>"edit", :controller=>"categories"}
#      category GET    /categories/:id(.:format)      {:action=>"show", :controller=>"categories"}
#              PUT    /categories/:id(.:format)      {:action=>"update", :controller=>"categories"}
#              DELETE /categories/:id(.:format)      {:action=>"destroy", :controller=>"categories"}


  resources :posts

  get "staff/index"
  match "staff" => 'staff#menu'

  get "staff/login"
  match "staff/login" => 'staff#send_login'

  get "staff/menu"

  get "staff/logout"
    
  controller :main do
    get   "main/index" => :index, :as => "main"
    match "main" => 'main#index'
    get   "main/view_post/:id" => :view_post,  :as => "post_view"
    post  "main/view_post/:id" => :add_comment,:as=> "add_comment"
    get   "main/categories/:id" => :category, :as => "category"
  end

 # get "main/index"
 # match "main" => 'main#index'

  get "main/list"

  get "main/category"

  get "main/archive/"

#  get "main/view_post"
#  match "main/view_post/:id" => 'posts#show'

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

   root :to => "main#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
