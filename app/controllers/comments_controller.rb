class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[ show update destroy ]
  before_action :set_post_to_comment, only: [:create]

  # # GET /comments
  # def index
  #   @comments = Comment.all

  #   render json: @comments
  # end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      render json: @comment, status: :created, location: post_comments_url(@post)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /comments/1
  # def update
  #   if @comment.update(comment_params)
  #     render json: @comment
  #   else
  #     render json: @comment.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /comments/1
  def destroy
    if @comment.user_id == current_user.id
      @comment.destroy
      render json: { id: params[:id], deleted: 'ok' }
    else
      render json: { errors: "You don't updanting other person posts." }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_post_to_comment
      @post = Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      render404
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
