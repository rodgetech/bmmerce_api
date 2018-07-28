Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :listings do
        resources :rentals, only: :index
      end
      resources :listings do
        get 'featured', on: :collection
        get 'user_listings', on: :collection
      end
      resources :rent_requests, only: :create
      resources :districts, only: :index
      post 'authenticate', to: 'authentication#authenticate'
      post 'register', to: 'registration#register'
      get 'search', to: 'search#search'
    end
  end
end
