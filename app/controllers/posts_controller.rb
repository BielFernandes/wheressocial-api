class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show update destroy ]

  def index
    @posts = Post.all
    @posts.map do |item|
      item.likes.map do | likes_post |
        if likes_post.user_id == current_user.id
          item.liked = true
        end
      end
    end
    
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.user.id == current_user.id
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    else
      render json: { errors: "You don't updanting other person posts." }, status: :unauthorized
    end

  end

  def destroy
    if @post.user.id == current_user.id
      @post.destroy
      render json: { id: params[:id], deleted: 'ok' }
    else
      render json: { errors: "You don't deleting other person posts." }, status: :unauthorized
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render404
    end

    def post_params
      params.require(:post).permit(:content, :current_user)
    end
end
