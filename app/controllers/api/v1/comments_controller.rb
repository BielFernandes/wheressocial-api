module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_comment, only: %i[ show update destroy ]
      before_action :set_commentable
      before_action :require_owner, only: [:destroy]
      # before_action :set_comment, only: %i[ show update destroy ]

      def index
        render json: @commentable.comments
      end

      def show
        render json: @comment
      end

      def create
        @comment = @commentable.comments.build(user_id: current_user.id)
        @comment.content = comment_params[:content]
        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @comment.destroy
          render json: { id: params[:id], deleted: 'ok' }
        else
          render json: { errors: "You don't updanting other person posts." }, status: :unauthorized
        end
      end

      private
        def set_commentable
          if params[:post_id]
            puts 'caiu aqui'
            @commentable = Post.find(params[:post_id])
          elsif params[:share_id]
            puts 'caiu ali'
            @commentable = Share.find(params[:share_id])
          end
        end

        def set_comment
          @comment = Comment.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render404
        end

        def comment_params
          params.require(:comment).permit(:content)
        end

        def require_owner
          unless current_user == @comment.user
            render json: { error: "You are not authorized to perform this action." }, status: :unauthorized
          end
        end

    end
  end
end