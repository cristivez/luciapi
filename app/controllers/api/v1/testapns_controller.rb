class Api::V1::TestapnsController < ApplicationController

  respond_to :json

  def test

    APNS.host = 'gateway.sandbox.push.apple.com'
    # gateway.sandbox.push.apple.com is default

    APNS.pem  = "#{Rails.root}/config/apns-dev-cert.pem"
    # this is the file you just created

    APNS.port = 2195


    device_token = '413b8b08a146ef0a5332b78c2f408442872d6ff4920d65a039c749b1acd5a8a3'


    user = User.find(3)
    oev = OnlineEvent.find(36)

    message = user.lastName + ' ' + user.firstName + ' te-a invitat la ' + oev.title

    APNS.send_notification(device_token, :alert => message, :badge => 1, :sound => 'default',:other => {:eventId => 1, :type => 0} )


    render json:{status: :ok}


  end

end
