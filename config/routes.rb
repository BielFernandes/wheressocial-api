Rails.application.routes.draw do
  resources :comments
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/user/:id', to: 'users#show_user_posts'
end
