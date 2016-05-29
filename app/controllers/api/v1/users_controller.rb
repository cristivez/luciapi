class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:show, :update, :destroy]
  before_action :current_user, only: [:show, :update, :destroy]

  respond_to :json

  def show
    # respond_with User.find(params[:id])

    if current_user
      render json: current_user, status: 200
    else
      render json: { errors: "Invalid token" }, status: 422
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :phoneNumber, :firstName, :lastName, :birthDate)
  end
end
