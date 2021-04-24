class Api::V1::ForecastController < ApplicationController

  def index
    forecasts = ForecastFacade.return_forecasts(params[:location])
  end

end
