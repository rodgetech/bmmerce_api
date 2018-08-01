Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :listing_type do
        resources :listings 
        resources :rentals, only: :index
      end
      
      namespace :admin do
        resources :listings
      end 
      
      namespace :auth do 
        post 'authenticate', to: 'authentication#authenticate'
        post 'authenticate/business', to: 'authentication#authenticate_business_user'
        post 'register', to: 'registration#register'
      end
     
      get 'search', to: 'search#search'
    end
  end
end
