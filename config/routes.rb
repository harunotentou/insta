Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: %i[new create]
  # ネストしたルーティング（shallowルーティング）
  resources :posts, shallow: true do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  root      'posts#index'
  get       '/login'    =>  'sessions#new'
  post      '/login'    =>  'sessions#create'
  delete    '/logout'   =>  'sessions#destroy'
end
