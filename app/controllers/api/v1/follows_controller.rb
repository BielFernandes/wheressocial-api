class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_existent, only: [ :create ]

  def user_followed
    @followed = Follow.where(followed_id: params[:user_id])
    if @followed.exists?
      render json: @followed
    else
      render404
    end
  end

  def user_followers
    @follower= Follow.where(follower_id: params[:user_id])
    if @follower.exists?
      render json: @follower
    else
      render404
    end
  end

  def create
    if current_user.id == params[:user_id].to_i
      return render json: {"message": "You cannot follow this action"}
    end
    
    @follow = Follow.new(follower_id: current_user.id, followed_id: params[:user_id])
    if @follow.save
      render json: @follow, status: :created
    else
      render json: @follow.errors, status: :unprocessable_entity
    end
  end

  def update
    if @follow.update(follow_params)
      render json: @follow
    else
      render json: @follow.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @follow.destroy
  end

  private
    def check_existent
      get_follow = Follow.exists?(follower_id: current_user.id, followed_id: params[:user_id])
      if get_follow
        return render json: 'aaa'
      end
    end
end
