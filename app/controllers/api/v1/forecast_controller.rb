class Api::V1::ForecastController < ApplicationController

  def index
    return_open_struct = ForecastFacade.coordinate_digest(params[:location])
  end

end
