module UserHelper
  def user_name(user)
    user.username
  end

  def user_email(user)
    user.email
  end

  def user_id(user)
    user.id
  end

  def user_token(user)
    user.token
  end
end
