class Api::V1::ImageController < ApplicationController

  def index
    @image = ImageFacade.return_image(params[:location])
    @serial = ImageSerializer.new(@image)
    render json: @serial
  end

end
