class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: %i[ show update destroy ]
  before_action :set_post_to_like, only: [:create]

  def create
    find_like = Like.find_by(user_id: current_user.id, post_id: @post.id)
    unless find_like
      @like = Like.new(user_id: current_user.id, post_id: @post.id)
      if @like.save
        render json: @like, status: :created
      else
        render json: { errors: @like.errors }, status: :unprocessable_entity
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
    end

end
