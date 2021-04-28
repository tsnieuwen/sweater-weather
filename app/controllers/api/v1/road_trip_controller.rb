class Api::V1::RoadTripController < ApplicationController

  # def create
  #   if params[:api_key]
  #     if User.find_by(api_key: params[:api_key])
  #       @road_trip = RoadTripFacade.return(params[:origin], params[:destination])
  #       @serial = RoadTripSerializer.new(@road_trip)
  #       render json: @serial
  #     else
  #       render json: {data: { error: "You are not able to access this feature"}}, status: 401
  #     end
  #   else
  #     render json: {data: { error: "You are not able to access this feature"}}, status: 401
  #   end
  # end

  def create
    if !params[:origin] || !params[:destination]
      render json: {data: { error: "Please enter valid origin and destination points"}}, status: 400
    else
      if params[:api_key]
        if User.find_by(api_key: params[:api_key])
          @road_trip = RoadTripFacade.return(params[:origin], params[:destination])
          if @road_trip == nil
            render json: {data: { error: "Please enter valid origin and destination points"}}, status: 400
          elsif @road_trip == "We are unable to route with the given locations."
            render json: {data: { error: "We are unable to route with the given locations."}}, status: 400
          else
            @serial = RoadTripSerializer.new(@road_trip)
            render json: @serial
          end
        else
          render json: {data: { error: "You are not able to access this feature"}}, status: 401
        end
      else
        render json: {data: { error: "You are not able to access this feature"}}, status: 401
      end
    end
  end

end
