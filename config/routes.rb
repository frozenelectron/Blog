Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :articles
  root "articles#index"

  resources :articles do
    resources :comments 
  end
  # Defines the root path route ("/")
  # root "articles#index"
end