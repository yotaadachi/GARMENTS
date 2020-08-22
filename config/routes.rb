Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about', as:'about'
  # get 'search' => 'garments#search', as:'search'
  resources :garments do
  	resources :comments, only: [:create, :destroy]
  	resources :favorites, only: [:index, :create, :destroy]
  end
  resources :users do
  get 'follows' => 'relationships#follows'
  get 'followers' => 'relationships#followers'
  end
  resources :relationships, only: [:create, :destroy]
end
