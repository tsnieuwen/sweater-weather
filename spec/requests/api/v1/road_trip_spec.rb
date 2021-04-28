require 'rails_helper'

describe "roadtrip happy path" do

  it "returns forecast data for trips under one hour" do
    VCR.use_cassette('happy_roadtrip_short') do

      existing_user1 = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      existing_user2 = User.create(email: "bill@turing.com", password: "HotelCalifornia", password_confirmation: 'HotelCalifornia', api_key: "lifeinthefastlane123")
      post '/api/v1/road_trip', params: {origin: "Taunton,MA", destination: "Bridgewater,MA", api_key: "jgn983hy48thw9begh98h4539h4"}

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(body[:data].keys).to eq([:id, :type, :attributes])
      expect(body[:data][:id]).to eq(nil)
      expect(body[:data][:type]).to eq("road_trip")
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

  it "returns forecast data for trips between an hour and two days" do
    VCR.use_cassette('happy_roadtrip_mid') do

      existing_user1 = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      existing_user2 = User.create(email: "bill@turing.com", password: "HotelCalifornia", password_confirmation: 'HotelCalifornia', api_key: "lifeinthefastlane123")
      post '/api/v1/road_trip', params: {origin: "Taunton,MA", destination: "Burlington,VT", api_key: "jgn983hy48thw9begh98h4539h4"}

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(body[:data].keys).to eq([:id, :type, :attributes])
      expect(body[:data][:id]).to eq(nil)
      expect(body[:data][:type]).to eq("road_trip")
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

  it "returns forecast data for trips over two days" do
    VCR.use_cassette('happy_roadtrip_long') do

      existing_user1 = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      existing_user2 = User.create(email: "bill@turing.com", password: "HotelCalifornia", password_confirmation: 'HotelCalifornia', api_key: "lifeinthefastlane123")
      post '/api/v1/road_trip', params: {origin: "Taunton,MA", destination: "Chicago,IL", api_key: "jgn983hy48thw9begh98h4539h4"}

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(body[:data].keys).to eq([:id, :type, :attributes])
      expect(body[:data][:id]).to eq(nil)
      expect(body[:data][:type]).to eq("road_trip")
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

describe "roadtrip sad paths" do

  it "returns error when input api key doesn't exist in users db" do
    VCR.use_cassette('roadtrip_sad_path_one') do

      existing_user1 = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      existing_user2 = User.create(email: "bill@turing.com", password: "HotelCalifornia", password_confirmation: 'HotelCalifornia', api_key: "lifeinthefastlane123")
      post '/api/v1/road_trip', params: {origin: "Denver,CO", destination: "Colorado Springs,CO", api_key: "jgn3hy48thw9begh98h4539h4"}

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data].keys).to eq([:error])
      expect(body[:data][:error]).to eq("You are not able to access this feature")
    end
  end

  it "returns error when no api key is provided" do
    VCR.use_cassette('roadtrip_sad_path_two') do

      existing_user1 = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      existing_user2 = User.create(email: "bill@turing.com", password: "HotelCalifornia", password_confirmation: 'HotelCalifornia', api_key: "lifeinthefastlane123")
      post '/api/v1/road_trip', params: {origin: "Denver,CO", destination: "Colorado Springs,CO"}

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data].keys).to eq([:error])
      expect(body[:data][:error]).to eq("You are not able to access this feature")
    end
  end

  it "returns error when origin is not entered" do
    VCR.use_cassette('roadtrip_sad_path_no_origin') do

      existing_user1 = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      existing_user2 = User.create(email: "bill@turing.com", password: "HotelCalifornia", password_confirmation: 'HotelCalifornia', api_key: "lifeinthefastlane123")
      post '/api/v1/road_trip', params: {destination: "Colorado Springs,CO", api_key: "jgn983hy48thw9begh98h4539h4"}

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data].keys).to eq([:error])
      expect(body[:data][:error]).to eq("Please enter valid origin and destination points")
    end
  end

  it "returns error when destination is not entered" do
    VCR.use_cassette('roadtrip_sad_path_no_origin') do

      existing_user1 = User.create(email: "tommy@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      existing_user2 = User.create(email: "bill@turing.com", password: "HotelCalifornia", password_confirmation: 'HotelCalifornia', api_key: "lifeinthefastlane123")
      post '/api/v1/road_trip', params: {origin: "Colorado Springs,CO", api_key: "jgn983hy48thw9begh98h4539h4"}

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data].keys).to eq([:error])
      expect(body[:data][:error]).to eq("Please enter valid origin and destination points")
    end
  end

  it "returns error when origin is not valid" do
    VCR.use_cassette('sad_path_invalid_origin') do

      existing_user1 = User.create(email: "hank@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      post '/api/v1/road_trip', params: {origin: "asdfsdf2134123asdfasdf123123", destination: "Denver,CO", api_key: "jgn983hy48thw9begh98h4539h4"}

      body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data].keys).to eq([:error])
      expect(body[:data][:error]).to eq("Please enter valid origin and destination points")
    end
  end

  it "returns error when destination is not valid" do
    VCR.use_cassette('sad_path_invalid_destination') do

      existing_user1 = User.create(email: "hank@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      post '/api/v1/road_trip', params: {origin: "Denver,CO", destination: "asdfsdf2134123asdfasdf123123", api_key: "jgn983hy48thw9begh98h4539h4"}

      body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data].keys).to eq([:error])
      expect(body[:data][:error]).to eq("Please enter valid origin and destination points")
    end
  end

  it "returns error when trip is impossible" do
    VCR.use_cassette('sad_path_invalid_trip') do

      existing_user1 = User.create(email: "hank@turing.com", password: "TakeItEasy", password_confirmation: 'TakeItEasy', api_key: "jgn983hy48thw9begh98h4539h4")
      post '/api/v1/road_trip', params: {origin: "Denver,CO", destination: "London", api_key: "jgn983hy48thw9begh98h4539h4"}

      body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(body[:data]).to be_a(Hash)
      expect(body[:data].keys).to eq([:error])
      expect(body[:data][:error]).to eq("We are unable to route with the given locations.")
    end
  end

end
