Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about', as:'about'
  resources :garments do
  	resources :comments, only: [:create, :destroy]
  	resource :favorites, only: [:create, :destroy]
    collection do
      match 'sort' => 'garments#sort', via: [:get, :post]
    end
  end
  get 'users/:id/myindex' => 'users#myindex', as:'myindex'
  resources :users do
  get 'follows' => 'relationships#follows'
  get 'followers' => 'relationships#followers'
  get 'favorites' => 'favorites#index'
  end
  resources :relationships, only: [:create, :destroy]
end
