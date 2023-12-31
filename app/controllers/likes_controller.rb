class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: %i[ show update destroy ]
  before_action :set_likeable
  before_action :find_existent, only: [:create]
  # before_action :set_post_to_like, only: [:create]
  before_action :require_owner, only: [:destroy]

  def index
  
    render json: @likeable.likes

  end

  def create

    @like = @likeable.likes.build(user_id: current_user.id)
    if @like.save
      render json: @like, status: :created
    else
      render json: @like.errors, status: :unprocessable_entity
    end

  end

  def destroy

    if @like.destroy
      render json: { id: params[:id], deleted: 'ok' }
    else
      render json: @like.errors, status: :unprocessable_entity
    end

  end

  private
  
    def set_likeable

      if params[:post_id]
        @likeable = Post.find(params[:post_id])
      elsif params[:share_id]
        @likeable = Share.find(params[:share_id])
      end

    end

    def find_existent
      existent_like = Like.exists?(user_id: current_user.id, likeable_id: @likeable.id, likeable_type: @likeable.class.name)
      if existent_like
        render json: { message: "You have already liked this." }, status: :unprocessable_entity
      end
    end

    def set_like
      @like = Like.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render404
    end

    def require_owner
      unless current_user == @like.user
        render json: { error: "You are not authorized to perform this action." }, status: :unauthorized
      end
    end

end