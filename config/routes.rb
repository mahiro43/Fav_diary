Rails.application.routes.draw do
  root 'top#index' 

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favs, only: [:index, :new, :create, :show, :edit, :destroy, :update] do
    resources :diaries, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
      collection do
        get 'calendar'
        get 'search'
        get :autocomplete
      end
      member do
        delete 'delete_image/:image_id', to: 'diaries#delete_image', as: :delete_image
      end
    end
  end

  get 'login' => 'sessions#new', as: :login
  post 'logout' => 'sessions#destroy', as: :logout

  get 'signup', to: 'users#new'

  get '/kiyaku', to: 'kiyaku#terms'
  get '/privacy', to: 'kiyaku#privacy'
end