Rails.application.routes.draw do
  root to: 'home#index'

  resources :projects, only: [:create, :destroy]
  resources :panics, only: [:create]
end
