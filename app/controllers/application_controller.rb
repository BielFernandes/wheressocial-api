class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        def render404
                render json: { error: 'Not Found' }, status: :not_found
        end
end
