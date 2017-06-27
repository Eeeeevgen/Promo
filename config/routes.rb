Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "main#index"
  post "image" => "main#image"
  get "/test" => "main#test"

  get '/login', :to => 'sessions#new', :as => :login
  get '/logout', :to => 'sessions#destroy', :as => :logout


  get 'sign_up' => 'users#new', as: :sign_up
  post 'sign_up' => 'users#create', as: :sign_up_post

  match '/auth/:provider/callback' => 'sessions#create', via: :all
  match '/auth/failure' => 'sessions#failure', via: :all
end
