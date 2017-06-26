Rails.application.routes.draw do
  root to: 'pages#home'

  get 'pages/welcome'
  devise_for :users
  resources :users
  get '/users/send_email/:id' => 'users#send_email', as: :user_send_email
end
