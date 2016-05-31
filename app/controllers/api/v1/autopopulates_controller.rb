class Api::V1::AutopopulatesController < ApplicationController

  # before_action :authenticate_with_token!, only: [:autopopulate]

  respond_to :json

  def autopopulate

    agenda = params[:agenda]

    results = Array.new();

    agenda.each do |number|

      friend =  User.find_by(phoneNumber: number[:numbers])

      if friend
        results.push({:user => friend})
      end

    end

    render json: { result: results}, status: 200
  end

end
