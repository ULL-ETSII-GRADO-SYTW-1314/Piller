Piller::Application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :usuarios
  resources :sessions, only: [:new, :create, :destroy]
  resources :microvideos, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]


  root :to => 'static_pages#home' 
  
  match '/home',    to: 'static_pages#home', via: [:get, :post]
  match '/help',    to: 'static_pages#help', via: [:get, :post]
  match '/about',   to: 'static_pages#about', via: [:get, :post]
  match '/contact', to: 'static_pages#contact', via: [:get, :post]
  match '/signup',  to: 'usuarios#new', via: [:get, :post]
  match '/signin',  to: 'sessions#new', via: [:get, :post]
  match '/signout', to: 'sessions#destroy', via: :delete
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
