module Api
  module V1
    class FollowsController < ApplicationController
      before_action :authenticate_user!
      before_action :check_existent, only: [ :destroy ]

      def user_followed
        @followed = Follow.where(followed_id: params[:user_id])
        render json: @followed
      end

      def user_followers
        parameter = params[:user_id].to_i
        @follower= Follow.where(follower_id: parameter)
        render json: @follower

      end

      def create
        if current_user.id == params[:user_id].to_i
          return render json: {"message": "You cannot follow this action"}, status: :unprocessable_entity
        end

        @follow = Follow.new(follower_id: current_user.id, followed_id: params[:user_id])
        if @follow.save
          render json: @follow, status: :created
        else
          render json: @follow.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @follow_register.destroy
          render json: { "message": "deletaded" }, status: :no_content
        end
      end

      private
      def check_existent
        check_follow = Follow.exists?(follower_id: current_user.id, followed_id: params[:user_id])
        unless check_follow
          return render json: {"message": "You cannot follow this action"}, status: :unprocessable_entity
        end
        @follow_register = Follow.find_by(follower_id: current_user.id, followed_id: params[:user_id])
      end
    end
  end
end