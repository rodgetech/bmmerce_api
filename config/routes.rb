Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :listing_type do
        resources :listings 
        resources :rentals, only: :index
        resources :businesses, only: :show
      end
      
      namespace :admin do
        resources :listings
        resource :account
        resource :business
        resources :engagements do
          resources :messages
        end
        resources :messages, only: :create
      end 
      
      namespace :auth do 
        post 'authenticate', to: 'authentication#authenticate'
        post 'authenticate/business', to: 'authentication#authenticate_business_user'
        post 'register', to: 'registration#register'
      end
      resources :businesses
      get 'search', to: 'search#search'
    end
  end
end
