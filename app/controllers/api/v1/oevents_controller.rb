class  Api::V1::OeventsController < ApplicationController
  respond_to :json

  def create
    event = params[:event]
    title = event[:title]
    description = event[:description]
    latitude = event[:latitude]
    longitude = event[:longitude]
    date = event[:date]

    owner = User.find_by(email: event[:owner])

    APNS.host = 'gateway.sandbox.push.apple.com'
    APNS.pem  = '/Users/Jarvis/Documents/_fac/workspace/LuciApi/config/apns-dev-cert.pem'
    APNS.port = 2195

    results = Array.new();

    onlineEvent = OnlineEvent.new(owner: owner.id ,title: title, description: description, latitude: latitude, longitude: longitude, eventDate: date)
    if onlineEvent.save

      guests = event[:guests]
      if guests
        guests.each do |guestNumber|

          guest = OnlineEventGuest.new(phoneNumber: guestNumber[:numbers], oid: onlineEvent.id)
          guest.save

          friend =  User.find_by(phoneNumber: guestNumber[:numbers])

          if friend
            devices = Device.where(user_id: friend.id)
            devices.each do |device|

              APNS.send_notification(device.uuid, :alert => 'Ai fost invitata la un eveniment!', :badge => 1, :sound => 'default',:other => {:eventId => onlineEvent.id} )
            end
          end
          results.push({:user => friend})
        end
      end
      render json:{owner:owner, event: onlineEvent, guests:results}, status:201
    else
      render json: { errors: onlineEvent.errors }, status: 422
    end
  end

  def update

    # if user.update(user_params)
    #   render json: user, status: 200, location: [:api, user]
    # else
    #   render json: { errors: user.errors }, status: 422
    # end
  end

  def show

    user = User.find_by(email: params[:email])

    ownerEventsResult = Array.new();

    ownerEvents = OnlineEvent.where(owner: user.id).where(status: true)

    if ownerEvents
      ownerEvents.each do |event|

        ownerEventHash = Hash.new();
        ownerEventHash[:owner] = user
        ownerEventHash[:event] = event
        guestEventsResult = Array.new();

        guests = OnlineEventGuest.where(oid: event.id)
        if guests
          guests.each do |guest|
            user = User.find_by(phoneNumber: guest.phoneNumber)
            guestEventsResult.push(:user => user)
          end
        end

        ownerEventHash[:guests] = guestEventsResult

        ownerEventsResult.push(:events => ownerEventHash)
      end
    end


    eventAsGuestResult = Array.new();

    eventsAsGuest = OnlineEventGuest.where(phoneNumber: user.phoneNumber)
    if eventsAsGuest

      eventsAsGuest.each do |eventAsGuest|

        event = OnlineEvent.find(eventAsGuest.oid)
        if event.status
          owner = User.find(event.owner)


          ownerEventHash = Hash.new();
          ownerEventHash[:owner] = owner
          ownerEventHash[:event] = event
          guestEventsResult = Array.new();

          guests = OnlineEventGuest.where(oid: event.id)
          if guests
            guests.each do |guest|
              user = User.find_by(phoneNumber: guest.phoneNumber)
              guestEventsResult.push(:user => user)
            end
          end

          ownerEventHash[:guests] = guestEventsResult
          eventAsGuestResult.push(:events => ownerEventHash)
        end
      end
    end

    render json:{eventAsOwner:ownerEventsResult,eventAsGuest: eventAsGuestResult}, status:201

  end

  def delete

    event = OnlineEvent.find(params[:id])

    if event.update(status: false)
      render json:{status: 200}, status:201
    else
      render json:{error: event.error}, status: 401
    end
  end


end
