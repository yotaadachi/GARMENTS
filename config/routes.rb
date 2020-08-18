Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about', as:'about'
  resources :posts do
  	resources :comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end
  resources :users do
  get 'follows' => 'relationships#follows'
  get 'followers' => 'relationships#followers'
  end
  resources :relationships, only: [:create, :destroy]
end
