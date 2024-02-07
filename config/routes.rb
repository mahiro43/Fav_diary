Rails.application.routes.draw do
  root 'top#index'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favs, only: [:index, :new, :create]

  get 'login' => 'sessions#new', as: :login
  post 'logout' => 'sessions#destroy', as: :logout

  get 'signup', to: 'users#new'
end
