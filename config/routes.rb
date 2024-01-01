# Rails.application.routes.draw do
#   # resources :follows
#   resources :posts do
#     resources :comments
#     resources :likes
#   end



#   post '/follows/:user_id', to: 'follows#create'
#   get '/:user_id/followed', to: 'follows#user_followed'
#   get '/:user_id/followers', to: 'follows#user_followers'

#   post '/shares/:post_id', to: 'shares#create'
#     # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Defines the root path route ("/")
#   # root "articles#index"
#   get '/user/:id', to: 'users#show_user_posts'

#   get '/feed', to: 'users#current_user_posts'
# end

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :testes
      resources :posts do
        resources :comments
        resources :likes
      end
      resources :shares do
        resources :comments
        resources :likes
      end

      post '/follows/:user_id', to: 'follows#create'

      get '/:user_id/followed', to: 'follows#user_followed'
      get '/:user_id/followers', to: 'follows#user_followers'

      post '/shares/:post_id', to: 'shares#create'
      get '/user/:id', to: 'users#show_user_posts'

      get '/feed', to: 'users#current_user_posts'
    end

    # namespace :v2 do
    #   resources :users
    # end
  end
end