class Api::V1::SessionsController < ApplicationController
  before_action :current_user, only: [:destroy]
  respond_to :json

  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user_uuid = params[:session][:uuid]
    user = user_email.present? && User.find_by(email: user_email)

    if user && user.valid_password?(user_password)
      sign_in user, store: false

      user.device.create(user_id: user.id , uuid: user_uuid)
      user.save
      render :json =>{
        :user => user,
        :status => :ok,
        :auth_token => Device.find_by(uuid: user_uuid).auth_token
      }, status: 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy

    device = Device.find_by(auth_token: request.headers['Authorization'])
    if device
      device.generate_authentication_token!
      device.save
      head 204

    else
      render json: { errors: "Invalid token" }, status: 422
    end
  end
end
