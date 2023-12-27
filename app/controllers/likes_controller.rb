class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: %i[ show update destroy ]
  before_action :set_post_to_like, only: [:create]

  def create
    find_like = Like.find_by(user_id: current_user.id, likeable_id: @post.id)
    unless find_like
      @like = @post.likes.build(user_id: current_user.id)
  
      if @like.save
        render json: @like, status: :created, location: post_likes_url(@post)
      else
        render json: @like.errors, status: :unprocessable_entity
      end
    else
      render json: { errors: "Have you already liked." }, status: :unauthorized
    end
  end

  def destroy
    if @like.user_id == current_user.id
      @like.destroy
      render json: { id: params[:id], deleted: 'ok' }
    else
      render json: { errors: "You don't deleting other person posts." }, status: :unauthorized
    end
  end

  private

    def set_post_to_like
      @post = Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      render404
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render404
    end

end
