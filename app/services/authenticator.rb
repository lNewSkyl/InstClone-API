class Authenticator < ApplicationService
  def initialize(user,password)
    @user = user
    @password = password
  end

  def call
    if @user&.authenticate(@password)
      JsonWebToken.encode(user_id: @user.id)
    end
  end

end
