Rails.application.routes.draw do
  get 'tags/index'

  devise_for :users
  root 'prototypes#index'

  resources :prototypes, only: [:index, :new, :create, :show, :destroy, :edit, :update] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :tags, only: [:index]
  resources :users, only: [:show, :edit, :update]
end
