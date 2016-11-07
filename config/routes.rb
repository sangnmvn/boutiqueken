Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get "home/subregions"
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:

  resources :users do
    member do
      get 'profile'
      get 'dashboard' 
      get 'address_book'
      get 'orders' 
    end
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

  resource :shopping_carts do 
    collection do
      get "billing"
    end
  end

  resources :orders do 
    member do
      get 'payment'
      get 'confirm'
      put 'confirmed'
    end
  end

  resources :shopping_cart_items, only: [:update]
  # get 'admin/index'
  # get 'admin/scrapper'
  # put 'admin/interact_with_scrapper'

  resources :admin do
    collection do
      get '' => "admin#index"
      get 'index'
      get 'scrapper'
      get 'user_mgmt' 
      put 'interact_with_scrapper'
      get 'create_user'
      put 'save_user'
      post 'delete_user'
    end
    resources :addresses
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
end
