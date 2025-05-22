Rails.application.routes.draw do
  get "panels/index"
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")

  root "repairs#index"

  resources :repairs do
    member do
      post :add_images
      delete :remove_image
      post :lock
      post :unlock
      post :add_status
      post :add_repair_item
      delete :remove_repair_item
      get :load_inventory
      patch :reopen
    end
  end

  resources :devices
  resources :users

  resources :statuses do
    member do
      patch :toggle_active  # Handles both activation/deactivation
    end
  end

  resources :inventories
  resources :pricings
end
