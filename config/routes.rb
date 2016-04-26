Rails.application.routes.draw do
  resources :phase_lead_requests
  resources :phase_days
  resources :challenges
  resources :cohorts
  resources :locations
  resources :interactions
  resources :users
  root to: 'visitors#index'
  get '/about' => 'visitors#about'
  get '/visitors' => 'visitors#index'
  get '/welcome' => 'visitors#welcome'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  get '/admin' => 'admin#index'
  scope '/admin' do    
    get '/lead_for_the_day' => 'phase_lead_requests#index'
    get '/advisees' => 'admin#advisees'
  end
  # get '*paths' => 'visitors#index'
end
