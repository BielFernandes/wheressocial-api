module Api
  module V1
    class SharesController < ApplicationController
      before_action :authenticate_user!
      before_action :share_params, only: %i[ create update ]
      before_action :set_share, only: %i[ show update destroy ]
      before_action :set_post_to_share, only: [:create]
      before_action :require_owner, only: [:edit, :update, :destroy]

      def index
        @shares = Share.all

        render json: @shares
      end

      def show
        render json: @share
      end

      def create
        @share = Share.new(user_id: current_user.id, post_id: @post.id, content: share_params[:content])

        if @share.save
          render json: @share, status: :created
        else
          render json: @share.errors, status: :unprocessable_entity
        end

      end

      def update
        if @share.update(share_params)
          render json: @share
        else
          render json: @share.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @share.destroy
          render json: {"message": "deleted."}, status: :no_content
        else
          render json: @share.errors, status: :unprocessable_entity
        end
      end

      private
        def set_post_to_share
          @post = Post.find(params[:post_id])
          rescue ActiveRecord::RecordNotFound
            render404
        end
        
        def set_share
          @share = Share.find(params[:id])
          rescue ActiveRecord::RecordNotFound
            render404
        end

        def share_params
          params.require(:share).permit(:content)
        end

        def require_owner
          unless current_user == @share.user
            render json: { error: "You are not authorized to perform this action." }, status: :unauthorized
          end
        end

    end
  end
end