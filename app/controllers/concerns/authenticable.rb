module Authenticable

  # Devise methods overwrites
  def current_user
    device = Device.find_by(auth_token: request.headers['Authorization'])
    if device
      user_id = device.user_id
      @current_user ||= User.find(user_id)
    end
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
    status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

end
