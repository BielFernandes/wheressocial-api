module Api
   module V1
      class UsersController < ApplicationController
      before_action :authenticate_user!
      before_action :set_user, only: %i[ find_param_user ]
      
      def find_param_user
         render json: @get_user
      end

      private
      def set_user
         @get_user = User.find(params[:user_id])
         rescue ActiveRecord::RecordNotFound
         render404
      end

      end
   end
end