class Api::V1::SessionsController < ApplicationController

  # def create
  #   user = User.new(email: params[:email].downcase, password: params[:password], password_confirmation: params[:password_confirmation], api_key: SecureRandom.hex)
  #   if user.save
  #     @serial = UsersSerializer.new(user)
  #     render json: @serial, status: 201
  #   else
  #     render json: {data: { error: "There was an error processing this request. User email already exists, or your passwords did not match"}}, status: 400
  #   end
  #
  # end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user.present? && user.authenticate(params[:password])
      @serial = UsersSerializer.new(user)
      render json: @serial, status: 200
    else
      render json: {data: { error: "There was a problem with your credentials"}}, status: 400
    end 
  end


end
