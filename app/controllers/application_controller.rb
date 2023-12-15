class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        before_action :configure_permitted_parameters, if: :devise_controller?
        # before_action :check_empty_request_body

        def render404
                render json: { error: 'Not Found' }, status: :not_found
        end

        # private
        # def check_empty_request_body
        #         if request.body.read.blank?
        #           puts 'THE REQUEST BODY IS EMPTY.'
        #           render json: { error: "don't send data." }, status: :unprocessable_entity
        #         end
        # end

        protected
        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        end
end
