Rails.application.routes.draw do
  devise_for :users

   resources :categories
   resources :products
   resources :product_categories
   resources :stores
   resources :orders
   resources :users
   resources :pages
   resources :carts

   root 'pages#guest'
   get 'admin_home' , to: 'pages#admin_home'
   get 'owner_home' , to: 'pages#owner_home'
   get 'lowest_price' , to: 'pages#lowest_price'
   get 'highest_price' , to: 'pages#highest_price'
   get 'product_by_store/:id' ,to: 'pages#product_by_store' ,as: 'product_by_store'
   
   # owner product routes
   get 'owner_product' , to: 'products#owner_product'
   get 'owner_new_product' , to: 'products#owner_new_product'
   post 'owner_new_product' , to: 'products#create_owner_product'
   get "edit_owner_product/:id" => "products#edit_owner_product",as: 'edit_owner_product'
   patch "edit_owner_product/:id" => "products#update_owner_product"
   delete ":id" => "products#destroy_owner_product" , as: "destroy_owner_product"
  

    # owner store routes

   get 'owner_store' , to: 'stores#owner_store'
   get 'owner_new_store' , to: 'stores#owner_new_store'
   post 'owner_new_store' , to: 'stores#create_owner_store'
   get "edit_owner_store/:id" => "stores#edit_owner_store",as: 'edit_owner_store'
   patch "edit_owner_store/:id" => "stores#update_owner_store"
   delete "destroy_owner_store/:id" => "stores#destroy_owner_store" , as: "destroy_owner_store"


   get 'search' ,to: 'pages#search'
   devise_scope :user do
   get "/new_owner" => "users/registrations#new_owner"
   post "/new_owner" => "users/registrations#create"

   put '/carts/:id' => 'carts#update', as: 'update_quantity'
   delete '/carts/:id' => 'carts#destroy', as: 'delete_item'

   get 'checkout' , to: 'carts#checkout'

   get 'purchase_order' , to: 'orders#purchase_order'


  end

end
