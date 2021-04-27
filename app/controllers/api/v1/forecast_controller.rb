class Api::V1::ForecastController < ApplicationController

  def index
    if params[:location] == ""
      render json: {data: { error: "Please enter a valid location"}}, status: 400
    else
      @forecasts = ForecastFacade.return_forecasts(params[:location])
      if @forecasts
        @serial = ForecastSerializer.new(@forecasts)
        render json: @serial
      else
        render json: {data: { error: "Please enter a valid location"}}, status: 400
      end
    end
  end
end
