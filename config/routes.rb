require 'sidekiq/web'

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
  # acitivityのルーティング
  resources :activities, only: [] do
    patch :read, on: :member
  end
  namespace :mypage do
    resource :account, only: %i[edit update]
    resources :activities, only: %i[index]
    resource :notification_setting, only: %i[edit update]
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
    mount Sidekiq::Web, at: '/sidekiq'
  end
  root      'posts#index'
  get       '/login'    =>  'sessions#new'
  post      '/login'    =>  'sessions#create'
  delete    '/logout'   =>  'sessions#destroy'
end
