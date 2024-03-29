Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'
  
  # devise_scope :user do
  #   # get "/secure-user-sign-in-up"   => "devise/sessions#new",       as: "new_user_session"
  #   # post "/secure-user-sign-in-up"  => "devise/sessions#create",    as: "user_session"
  #   # delete "/users/sign_out"        => "devise/sessions#destroy",   as: "destroy_user_session"
  #   # get "/secure-sign-up"           => "devise/registrations#new",  as: "new_user_registration"
  #   # post "/secure-sign-up"           => "devise/registrations#create",  as: "user_registration"
  #   # #put "/users/password"      => "devise/passwords#update", as: "user_password"
  #   # get "/secure-user-forgot"      => "devise/passwords#new", as: "new_user_password"
  #   # get "/secure-user-update-pass"      => "devise/passwords#edit", as: "edit_user_password"
  #   # post "/secure-user-forgot"      => "devise/passwords#create",as: "user_password"
  #   # put "/secure-user-forgot"      => "devise/passwords#update",as: "update_user_password"

    
    
  # end
  get "/my-profile"               => "users#profile",             as: "profile_user",         format: false
    get "/my-dashboard"             => "users#dashboard",           as: "dashboard_user",       format: false
    get "/my-address-book"          => "users#address_book",        as: "address_book_user",    format: false
    get "/my-orders"                => "users#orders",              as: "orders_user",          format: false
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get "home/subregions"

  get "/contact-us" => "home#contact_us"
  get "/about-us" =>"home#about_us"
  get "/faq" => "home#faq"
  get "/domestic-shipping-and-return" =>"home#domestic_shipping_return"
  get "/international-shipping-and-return" =>"home#international_shipping_return"
  get "/privacy-policy" =>"home#privacy_policy"
  get "/safe-shopping-guarantee" =>"home#safe_shopping_guarantee"
  get "/secure-shopping" =>"home#secure_shopping"
  get "/term-of-use" =>"home#term_of_use"
  get "/country-choser" =>"home#country_chooser"
  get "/update-country" =>"home#update_country"
  post "/contact-us" =>"home#submit_contact"
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  get "/brand/:search_txt" => "products#search", :as => :brand_search

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:


  resources :users do
    # member do
      # get 'profile'
      # get 'dashboard' 
      # get 'address_book'
      # get 'orders' 
    # end
    resources :addresses
  end

  resources :products,path: 'pro' do 
    collection do
      get 'search'
    end
  end

  resources :categories, path: 'cat' do
    resources :products, path: 'pro', only: [:show]
  end

  get "/secure-connection/billing" => "shopping_carts#billing", as: "billing_shopping_carts"
  post "/secure-shopping-your-cart" => "shopping_carts#create", as: "shopping_carts"
  get "/secure-shopping-your-cart/new" => "shopping_carts#new", as: "new_shopping_carts"
  get "/secure-shopping-your-cart/edit" => "shopping_carts#edit", as: "edit_shopping_carts"
  get "/secure-shopping-your-cart" => "shopping_carts#show"
  patch "/secure-shopping-your-cart" => "shopping_carts#update"
  put "/secure-shopping-your-cart" => "shopping_carts#update"
  delete "/secure-shopping-your-cart" => "shopping_carts#destroy"

  # resource :shopping_carts do 
    # collection do
      # get "billing"
    # end
  # end


  get "/secure-connection/payment-options" => "orders#payment", as: "payment_order",    format: false
  get "/secure-connection/submit-final-order" => "orders#confirm", as: "confirm_order", format: false

  resources :orders do 
    member do
      # get 'payment'
      # get 'confirm'
      put 'confirmed'
    end
    collection do 
      post 'delete_comment'
    end
  end
  resources :shopping_cart_items, only: [:update]

  resources :admin do
    collection do
      get '' => "admin#index"
      get 'login'
      get 'logout'
      post 'signin'
      get 'index'
      get 'scrapper'
      get 'user_mgmt' 
      get 'my_profile' 
      put 'interact_with_scrapper'
      get 'create_user'
      put 'save_user'
      post 'delete_user'
      get 'edit_user'
      get 'order_mgmt'
      get 'show_order'
      get 'order_detail'
      put 'change_status'
    end
  end

  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  # Below for all other routes:
  devise_for :users, :path => '', :path_names => { :sign_in => "secure-user-sign-in-up", :sign_up => "secure-sign-up",:password =>"secure-password"},:controllers => { :passwords => "passwords" }
end
