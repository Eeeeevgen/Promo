require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :admin_user, lambda { |u| u } do
    mount Sidekiq::Web => '/admin/sidekiq_default'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users, only: [:new, :create, :show, :edit]
  resources :user_sessions, only: [:create, :destroy]
  resources :images, only: [:show, :index]

  root 'images#index'
  post '/' => 'images#index'

  get '/login' => 'sessions#new', as: :login
  post '/login' => 'sessions#create', as: :login_post

  delete '/logout' => 'sessions#destroy', as: :logout

  get '/register' => 'users#new', as: :register
  post '/register' => 'users#create', as: :register_post

  get '/users/:id/edit' => 'users#edit'
  patch '/users/:id/edit' => 'users#update'

  match '/auth/:provider/callback' => 'sessions#create', via: :all
  match '/auth/failure' => 'sessions#failure', via: :all

  get '/images/:id' => 'images#show', as: :image_show
  get '/images/:id/like' => 'images#like', as: :like
  delete '/images/:id/' => 'images#delete'

  post '/image' => 'users#show'
  post '/avatar' => 'users#avatar'

  post '/addcomment' => 'images#comment'
  post '/uploadimage' => 'images#upload'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :destroy]
      resources :images, only: [:index, :create, :show, :destroy]
      post 'token' => 'users#token'
      delete 'token' => 'users#token_destroy'
    end
  end
end

# Rails.application.routes.default_url_options = {
#     host: 'localhost:3000'
# }
