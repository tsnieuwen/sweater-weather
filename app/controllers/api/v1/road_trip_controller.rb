class Api::V1::RoadTripController < ApplicationController

  def create
    if params[:api_key]
      if User.find_by(api_key: params[:api_key])
        @road_trip = RoadTripFacade.return(params[:origin], params[:destination])
        @serial = RoadTripSerializer.new(@road_trip)
        render json: @serial
      else
        render json: {data: { error: "You are not able to access this feature"}}, status: 401
      end
    else
      render json: {data: { error: "You are not able to access this feature"}}, status: 401
    end
  end


end
