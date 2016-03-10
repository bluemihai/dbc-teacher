Rails.application.routes.draw do
  resources :interactions
  resources :users
  root to: 'visitors#index'
  get '/about' => 'visitors#about'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  # get '*paths' => 'visitors#index'
end
