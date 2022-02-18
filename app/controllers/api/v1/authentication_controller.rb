module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :authorize_request, except: :login

      # POST /auth/login
      def login
        token = Authenticator.call(user, params[:password])
        if token
          render json: { token: token, username: user_name(user) }
        else
          render json: { error: 'unauthorized' }
        end
      end

      private


      def user
        @user = User.find_by_email(params[:email])
      end
    end
  end
end
