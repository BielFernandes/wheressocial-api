class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        before_action :configure_permitted_parameters, if: :devise_controller?
        before_action :check_empty_request_body

        def render404
                render json: { error: 'Not Found' }, status: :not_found
        end

        protected

        def check_empty_request_body
                if request.body.read.blank?
                  puts 'THE REQUEST BODY IS EMPTY(ApplicationController)'.red
                  render json: { error: "don't sent datas" }, status: :unprocessable_entity
                end
        end

        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        end
end
