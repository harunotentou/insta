Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index new create show]
  # ネストしたルーティング（shallowルーティング）
  resources :posts, shallow: true do
    # searchアクションのルーティング
    collection do
      get 'search'
    end
    resources :comments, only: %i[create edit update destroy]
  end
  # like
  # いいね機能のルーティング
  resources :likes, only: %i[create destroy]
  # follow_unfollow機能のルーティング
  resources :relationships, only: %i[create destroy]
  root      'posts#index'
  get       '/login'    =>  'sessions#new'
  post      '/login'    =>  'sessions#create'
  delete    '/logout'   =>  'sessions#destroy'
end
