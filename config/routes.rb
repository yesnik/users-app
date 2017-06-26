Rails.application.routes.draw do
  root to: 'pages#home'

  get 'pages/welcome'

  devise_scope :user do
    get "/sign_in" => "devise/sessions#new"
    get "/sign_up" => "users#new", as: "new_user_registration"
  end

  devise_for :users, path: 'users_manage', controllers: {registrations: 'users/registrations'}
  resources :users
  get '/users/send_email/:id' => 'users#send_email', as: :user_send_email
end
