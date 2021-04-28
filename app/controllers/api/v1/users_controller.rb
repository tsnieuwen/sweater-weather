class Api::V1::UsersController < ApplicationController

  def create
    if !params[:email] || !params[:password] || !params[:password_confirmation]
      render json: {data: { error: "Please make sure to enter your email, password, and password confirmation"}}, status: 400
    else
      user = User.new(email: params[:email].downcase, password: params[:password], password_confirmation: params[:password_confirmation], api_key: SecureRandom.hex)
      if user.save
        @serial = UsersSerializer.new(user)
        render json: @serial, status: 201
      else
        render json: {data: { error: "There was an error processing this request. User email already exists, or your passwords did not match"}}, status: 400
      end
    end
  end
end
