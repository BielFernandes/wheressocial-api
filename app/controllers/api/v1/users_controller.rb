class UsersController < ApplicationController
 before_action :authenticate_user!
 before_action :set_user, only: %i[ show_user_posts ]

 def show_user_posts
    render json: @user
 end
 
 def current_user_posts
   @posts = current_user.posts.all
   
   render json: @posts
 end

 private
 def set_user
    @user = User.find(params[:id])
 rescue ActiveRecord::RecordNotFound
    render404
 end

end