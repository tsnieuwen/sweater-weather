require 'rails_helper'

describe "roadtrip happy path" do

  it "returns forecast data per spec" do
    VCR.use_cassette('roadtrip') do

      existing_user1 = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      existing_user2 = User.create(email: "bill@turing.com", password: "HotelCalifornia", password_confirmation: 'HotelCalifornia', api_key: "lifeinthefastlane123")
      post '/api/v1/road_trip', params: {origin: "Denver,CO", destination: "Colorado Springs,CO", api_key: "jgn983hy48thw9begh98h4539h4"}

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(body[:data].keys).to eq([:id, :type, :attributes])
      expect(body[:data][:id]).to eq(nil)
      expect(body[:data][:type]).to eq("roadtrip")
      expect(body[:data][:attributes]).to be_a(Hash)
      expect(body[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(body[:data][:attributes][:start_city]).to be_a(String)
      expect(body[:data][:attributes][:end_city]).to be_a(String)
      expect(body[:data][:attributes][:travel_time]).to be_a(String)
      expect(body[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(body[:data][:attributes][:weather_at_eta].keys).to eq([:temperature, :conditions])
      expect(body[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(body[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
  end

end
