class Api::V1::ForecastController < ApplicationController

  def index
    @forecasts = ForecastFacade.return_forecasts(params[:location])
    @serial = ForecastSerializer.new(@forecasts)
    render json: @serial
  end

end
