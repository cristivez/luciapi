class Api::V1::SessionsController < ApplicationController
  before_action :current_user, only: [:destroy]
  respond_to :json

  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user_uuid = params[:session][:uuid]
    user_pushtoken = params[:session][:pushToken]
    user = user_email.present? && User.find_by(email: user_email)

    if user && user.valid_password?(user_password)
      sign_in user, store: false

      device = Device.where(user_id: user.id ,uuid: user_uuid).first

      if device.nil?
        user.device.create(user_id: user.id , uuid: user_uuid, pushtoken: user_pushtoken)
        user.save

      else
        device.generate_authentication_token!
        device.update(pushtoken: user_pushtoken)
        device.save
      end

      render :json =>{
        :user => user,
        :status => 200,
        :auth_token => Device.where(user_id:user.id ,uuid: user_uuid).first.auth_token
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
