require 'rails_helper'

describe "user login" do

  it "returns happy path" do
    existing_user = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: SecureRandom.hex)

    post '/api/v1/sessions', params: {email: "tommy@turing.com", password: "TakeItEasy" }

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(body[:data][:attributes]).to be_a(Hash)
    expect(body[:data][:attributes].keys).to eq([:email, :api_key])
    expect(body[:data][:attributes][:email]).to eq("tommy@turing.com")
    expect(body[:data][:attributes][:api_key]).to be_a(String)
  end

  it "returns sad path - wrong password" do
    existing_user = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: SecureRandom.hex)

    post '/api/v1/sessions', params: {email: "tommy@turing.com", password: "HotelCalifornia" }

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(body[:data][:error]).to eq("There was a problem with your credentials")
  end

  it "returns sad path - wrong email" do
    existing_user = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: SecureRandom.hex)

    post '/api/v1/sessions', params: {email: "bill@turing.com", password: "TakeItEasy" }

    body = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(body[:data][:error]).to eq("There was a problem with your credentials")
  end

end
