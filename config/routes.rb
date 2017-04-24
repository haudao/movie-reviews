Rails.application.routes.draw do
  resources :movies, only: %i(index show) do
    resources :comments
  end
  resources :users, only: %i(new create)
  get '/signup' => 'users#new', :as => 'signup'
  post '/signup' => 'users#create'
  resource :session, only: %i(new create destroy)
  get '/signin' => 'sessions#new', :as => 'signin'
  post 'signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => 'signout'
  root to: 'movies#index'
end
