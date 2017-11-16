Rails.application.routes.draw do

  get "users/new"
  get "/home", to: "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/help", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"
  root "static_pages#home"
  resources :users
end
