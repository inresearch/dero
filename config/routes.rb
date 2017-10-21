Rails.application.routes.draw do
  resources :projects, only: [:create, :update, :destroy]
end
