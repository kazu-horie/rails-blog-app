Rails.application.routes.draw do
  root 'home#home'

  get 'users/new', to: 'users#new', as: :new_user
  post 'users/create', to: 'users#create', as: :users
  post 'login', to: 'users#login', as: :login

  resources :articles
end
