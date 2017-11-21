Rails.application.routes.draw do
  root "static_pages#home"

  get "users/new"
  get "/home", to: "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/help", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
end
