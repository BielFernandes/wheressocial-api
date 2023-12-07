class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        before_action :configure_permitted_parameters, if: :devise_controller?

        def render404
                render json: { error: 'Not Found' }, status: :not_found
        end

        protected

        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        end
end
