Rails.application.routes.draw do
  # root route
  root to: 'images#index'
  
  # session routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # images routes
  resources :images, only: [:index, :new, :create] do
    get :share
  end

  # oAuth routes
  get 'oauth/callback'
  get 'oauth/authorize'
end
