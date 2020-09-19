Rails.application.routes.draw do
  # ログイン前
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'

  # garments関連
  resources :garments do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  # user関連
  get 'users/:id/myindex' => 'users#myindex', as: 'myindex'
  resources :users do
    get 'follows' => 'relationships#follows'
    get 'followers' => 'relationships#followers'
    get 'favorites' => 'favorites#index'
  end

  # フォロー機能
  resources :relationships, only: [:create, :destroy]

  # 検索機能
  get 'search' => 'searches#index'

  # 通知機能
  resources :notifications, only: :index
  delete 'notifications/destroy_all' => 'notifications#destroy_all', as: 'notifications_destroy_all'
end
