Rails.application.routes.draw do
  root to: 'pages#home'

  get 'pages/welcome'
  devise_for :users
  resources :users
end
