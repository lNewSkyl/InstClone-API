module Api
	module V1
		class SessionsController < ApplicationController
			def show 
				current_user ? head(:ok) : head(:unauthorized)
			end

			def create
				@user = User.where(email: params[:email]).first
				if @user&.valid_password?(params[:password])
					jwt = JWT.encode(
						{user_id: @user.id, exp: (Time.now + 2.weeks).to_i}, 
						Rails.application.secrets.secret_key_base, 
						'HS256'
					)
					render json: { email: @user.email, user_token: jwt }, status: :created
					# render :create, status: :created, locals: { token: jwt }
				else
					render json: { error: 'invalid_credentials' }, status: :unauthorized
				end
			end

			def destroy
				current_user&.authentication_token = nil
				if current_user&.save
					head(:ok)
				else
					head(:unauthorized)
				end
			end

		end
	end
end
