class Api::V1::TestapnsController < ApplicationController

  respond_to :json

  def test

    APNS.host = 'gateway.sandbox.push.apple.com'
       # gateway.sandbox.push.apple.com is default

       APNS.pem  = "#{Rails.root}/config/apns-dev-cert.pem"
       # this is the file you just created

       APNS.port = 2195


    device_token = '64fb0fd0226b4c79f3326c3d83b41433da9d79f4afb63226ac81f91954e3d48d'



          APNS.send_notification(device_token, :alert => 'Ai fost invitata la un eveniment!', :badge => 2, :sound => 'default' )



    render json:{status: :ok}


  end



end
