Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :listings
      post 'authenticate', to: 'authentication#authenticate'
      post 'register', to: 'registration#register'
    end
  end
end
