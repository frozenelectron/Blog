Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  root "articles#index"

  resources :articles do
    resources :comments
  end

  resources :registrations
  resources :sessions
  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token

  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"

  resources :passwords, only: [:create, :new, :edit, :update], param: :password_reset_token

  put "account", to: "registrations#update"
  get "account", to: "registrations#edit"
  delete "account", to: "registrations#destroy"

end
