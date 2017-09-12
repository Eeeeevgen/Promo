require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :admin_user do
    mount Sidekiq::Web, at: '/admin/sidekiq_default'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users, only: %i[new create show edit update]
  resources :user_sessions, only: %i[create destroy]
  resources :images, only: %i[show index destroy]

  root 'images#index'

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create', as: :login_post
  delete '/logout', to: 'sessions#destroy', as: :logout
  match '/auth/:provider/callback', to: 'sessions#create', via: :all
  match '/auth/failure', to: 'sessions#failure', via: :all

  get '/register', to: 'users#new', as: :register
  post '/register', to: 'users#create', as: :register_post
  post '/avatar', to: 'users#avatar'

  get '/images/:id/like', to: 'images#like', as: :like
  post '/addcomment', to: 'images#comment'
  post '/uploadimage', to: 'images#upload'

  # for per_page selector
  post '/', to: 'images#index'
  post '/users/:id', to: 'users#show'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index create show destroy]
      resources :images, only: %i[index create show destroy]
      post 'token', to: 'users#token'
      delete 'token', to: 'users#token_destroy'
    end
  end
end
