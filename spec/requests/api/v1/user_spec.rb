require 'rails_helper'

describe "user registration" do

  it "returns happy path" do
    balloons = SecureRandom.hex
    post '/api/v1/users', params: {email: "Apples123@oranges.com", password: "HotelCalifornia", password_confirmation: "HotelCalifornia", api_key: balloons }

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(body[:data][:attributes]).to be_a(Hash)
    expect(body[:data][:attributes].keys).to eq([:email, :api_key])
    expect(body[:data][:attributes][:email]).to eq("apples123@oranges.com")
    expect(body[:data][:attributes][:api_key]).to be_a(String)
    expect(response.status).to eq(201)
  end

  it "returns sad path for email already exists" do
    existing_user = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: SecureRandom.hex)

    post '/api/v1/users', params: {email: "tommy@turing.com", password: "HotelCalifornia", password_confirmation: "HotelCalifornia", api_key: SecureRandom.hex }

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data].keys).to eq([:error])
    expect(body[:data][:error]).to eq("There was an error processing this request. User email already exists, or your passwords did not match")

  end

  it "returns sad path for passwords don't match" do

    post '/api/v1/users', params: {email: "tommy@turing.com", password: "HotelCalifornia", password_confirmation: "TakeItEasy", api_key: SecureRandom.hex }

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(body[:data]).to be_a(Hash)
    expect(body[:data].keys).to eq([:error])
    expect(body[:data][:error]).to eq("There was an error processing this request. User email already exists, or your passwords did not match")

  end
end
