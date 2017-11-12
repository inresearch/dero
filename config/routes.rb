Rails.application.routes.draw do
  get 'home/index'

  root to: 'home#index'

  resources :projects, only: [:create, :destroy]
  resources :panics, only: [:create]
end
