Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :edit]
  resources :user_sessions, only: [:create, :destroy]

  root "main#index"

  post "/image" => "images#new"

  get "/test" => "main#test"

  get '/login', :to => 'sessions#new', :as => :login
  post '/login' => 'sessions#create', as: :login_post

  delete '/logout', :to => 'sessions#destroy', :as => :logout

  get '/register' => 'users#new', as: :register
  post '/register' => 'users#create', as: :register_post

  get 'users/:id/edit' => 'users#edit'
  patch 'users/:id/edit' => 'users#update'

  match '/auth/:provider/callback' => 'sessions#create', via: :all
  match '/auth/failure' => 'sessions#failure', via: :all
end
