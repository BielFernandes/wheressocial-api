Rails.application.routes.draw do
  resources :follows
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :posts do
    resources :comments
    resources :likes
  end

  resources :shares do
    resources :comments
    resources :likes
  end

  post '/shares/:post_id', to: 'shares#create'
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/user/:id', to: 'users#show_user_posts'

  get '/feed', to: 'users#current_user_posts'
end
