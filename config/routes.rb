Rails.application.routes.draw do
  resources :projects, only: [:create, :destroy]
end
