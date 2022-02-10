module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :authorize_request, except: :login

      # POST /auth/login
      def login
        if user&.authenticate(params[:password])
          token = Authenticator.call(user)
          if token
            render json: { token: token, username: user_name(user) }
          else
            render json: { error: 'unauthorized' }
          end
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end

      def user
        @user = User.find_by_email(params[:email])
      end
    end
  end
end
