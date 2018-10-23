
Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  namespace :api do
    namespace :v1 do
      namespace :listing_type do
        resources :users
        resources :listings 
        resources :rentals, only: :index
        resources :businesses, only: :show
      end
      
      namespace :admin do
        resources :listings
        resource :business
        resource :account do
          put 'address', on: :member
        end
        resources :engagements do
          patch 'mark_messages_read', on: :member
        end
        resources :messages do
          get 'unread', on: :collection
        end
        resources :images, only: :destroy
      end 
      
      namespace :auth do 
        post 'authenticate', to: 'authentication#authenticate'
        post 'authenticate/facebook', to: 'authentication#facebook_authenticate'
        post 'authenticate/google', to: 'authentication#google_authenticate'
        post 'authenticate/business', to: 'authentication#authenticate_business_user'
        post 'register', to: 'registration#register'
      end
      resources :businesses
      get 'search', to: 'search#search'
    end
  end
end
