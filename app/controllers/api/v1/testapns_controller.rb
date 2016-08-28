class Api::V1::TestapnsController < ApplicationController

  respond_to :json

  def test

    APNS.host = 'gateway.sandbox.push.apple.com'
       # gateway.sandbox.push.apple.com is default

       APNS.pem  = '#{Rails.root}/config/apns-dev-cert.pem'
       # this is the file you just created

       APNS.port = 2195


    device_token = 'dfa25cf785af051b1a9a1af36bbb0ab25c0292b51b8cf4871cafd646f0bcd251'


    friend =  User.find_by(phoneNumber: '0728065887')

    if friend
      devices = Device.where(user_id: friend.id)
      devices.each do |device|

          APNS.send_notification(device.pushtoken, :alert => 'Ai fost invitata la un eveniment!', :badge => 2, :sound => 'default' )


      end
    else

    end
    render json:{status: :ok}


  end



end
