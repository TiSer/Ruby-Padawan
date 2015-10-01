SimpleBlog::Application.routes.draw do
  
  get "comments/index"
  get "comments/show"
  match "set_status", to: 'comments#set_status', via: :all

  controller :users do
    get  "staff/users"            => :index,  :as => "users"
    post "staff/users/"           => :manage, :as => "manage_users"
    get  "staff/users/new"        => :manage, :as => "new_user"
    get  "staff/users/manage/:id" => :manage, :as => "users_manage"
    get  "staff/users/:id"        => :manage, :as => "edit_user"
    get  "staff/users/:id"        => :index,  :as => "user"
    put  "staff/users/:id"        => :manage, :as => "update_user"    
    delete "staff/users/:id"     => :manage, :as => "user_del" 
  end

  controller :categories do
    get "staff/categories"           => :index,   :as => "categories"
    post"staff/categories"           => :create,  :as => "manage_categories"
    get "staff/categories/new"       => :index,   :as => "new_category"
    get "staff/categories/:id"       => :index,   :as => "edit_category"
    get "staff/categories/:id"       => :index,   :as => "staff_category"
    put "staff/categories/:id"       => :update,  :as => "update_category"
    delete "staff/categories/:id"    => :destroy, :as => "del_category" 
  end

  resources :posts

  get "staff/index"
  match "staff", to: 'staff#menu', via: :all

  get "staff/login"
  post "staff/send_login"
  #match "staff/login" => 'staff#send_login'

  get "staff/menu"

  get "staff/logout"
    
  controller :main do
    get   "main/index" => :index, :as => "main"
    match "main", to: 'main#index', via: :all
    get   "main/view_post/:id" => :view_post,  :as => "post_view"
    post  "main/view_post/:id" => :add_comment,:as=> "add_comment"
    get   "main/categories/:id" => :category, :as => "category"
  end

  get "main/list" => "main#list"
  get "main/category" => "main#category"
  get "main/archive/" => "main#archive"

  root :to => "main#index"
end
