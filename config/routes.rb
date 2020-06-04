Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users,only:[:new,:create]
  resources :posts
  root      'posts#index'
  get       "/login"    =>  "sessions#new"
  post      "/login"    =>  "sessions#create"
  delete    "/logout"   =>  "sessions#destroy"
end
