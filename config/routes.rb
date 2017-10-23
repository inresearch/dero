Rails.application.routes.draw do
  resources :projects, only: [:create, :destroy]
  resources :panics, only: [:create]
end
