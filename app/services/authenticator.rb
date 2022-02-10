class Authenticator < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    token = JsonWebToken.encode(user_id: @user.id)
  end
end
