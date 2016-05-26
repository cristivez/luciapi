class DevicesController < ApplicationController

  respond_to :json

  def create

    device = Device.find(:uuid)

    if device.empty?
      device = Device.new(user_params)
    end
    device.generate_authentication_token!
    device.save
  end

  def update
    device = Device.find(:uuid)
    device.generate_authentication_token!
    device.save
  end
  
  # def destroy
  #   current_user.destroy
  #   head 204
  # end

  private

  def user_params
    params.require(:user).permit(:user_id, :uuid)
  end

end
