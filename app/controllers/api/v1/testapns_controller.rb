class Api::V1::TestapnsController < ApplicationController

  respond_to :json

  def test

    APNS.host = 'gateway.sandbox.push.apple.com'
       # gateway.sandbox.push.apple.com is default

       APNS.pem  = '/Users/Jarvis/Documents/_fac/workspace/LuciApi/config/apns-dev-cert.pem'
       # this is the file you just created

       APNS.port = 2195


    device_token = 'dfa25cf785af051b1a9a1af36bbb0ab25c0292b51b8cf4871cafd646f0bcd251'

   APNS.send_notification(device_token, 'Hello iPhone!' )


    render json:{status: :ok}
  end



end
