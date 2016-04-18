Rails.application.routes.draw do
  root to: "links#index"
  get "/login", to: "sessions#new"
  get "/sign_up", to: "users#new"
  resources :users, only: [:new, :create]
  resources :links, only: [:index]
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
end
