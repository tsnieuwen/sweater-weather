class Api::V1::SalariesController < ApplicationController

  # def index
  #   @image = ImageFacade.return_image(params[:location])
  #   @serial = ImageSerializer.new(@image)
  #   render json: @serial
  # end

  def index
    @salaries = SalariesFacade.return(params[:destination])
    @serial = SalariesSerializer.new(@salaries)
    render json: @serial
  end

end
