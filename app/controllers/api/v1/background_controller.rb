class Api::V1::BackgroundController < ApplicationController

  def index
    if params[:location] == ""
      render json: {data: { error: "Please enter a valid location"}}, status: 400
    else
      @image = ImageFacade.return_image(params[:location])
      @serial = ImageSerializer.new(@image)
      render json: @serial
    end
  end

end
