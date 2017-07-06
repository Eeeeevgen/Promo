Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get '/admin/images/:id/accept' => 'admin/images#accept'
  get '/admin/images/:id/decline' => 'admin/images#decline'

  resources :users, only: [:new, :create, :show, :edit]
  resources :user_sessions, only: [:create, :destroy]
  resources :images, only: [:show]

  root "main#index"

  get '/login', :to => 'sessions#new', :as => :login
  post '/login' => 'sessions#create', as: :login_post

  delete '/logout', :to => 'sessions#destroy', :as => :logout

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
  post '/uploadimage' => "images#upload"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :destroy]
      resources :images, only: [:index, :create, :show, :destroy]
    end
  end
end

Rails.application.routes.default_url_options = {
    host: 'localhost:3000'
}