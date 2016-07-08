Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  resources :guards
  # resources :shifts do
  #   collection { post :import }
  #   get :download_shifts
  #   get :search
  # end

  resources :shifts do
    collection { post :import }
    get :download_shifts
    collection do
      post '/found', to: 'shifts#found', as: 'found'
    end
  end


  get 'sign_up' => 'users#new', :as => 'sign_up'
  root :to => 'sessions#new'
  resources :users

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :schedules
  resources :sites
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  post 'shifts/new' => 'shifts#new'

  delete 'shifts' => 'shifts#remove_all'

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
