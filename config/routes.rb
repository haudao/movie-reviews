Rails.application.routes.draw do
  resources :movies, only: %i(index show)
  resources :users, only: %i(new create)
  get '/signup' => 'users#new', :as => 'signup'
  root to: 'movies#index'
end
