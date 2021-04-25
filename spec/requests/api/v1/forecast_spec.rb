require 'rails_helper'

describe "forecast return happy path" do

  it "returns three categories of forecasted data" do
    VCR.use_cassette('taunton_forecast') do
      get '/api/v1/forecast', params: {location: "taunton,ma" }
      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])

      expect(body[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(body[:data][:attributes][:daily_weather]).to be_a(Array)
      expect(body[:data][:attributes][:hourly_weather]).to be_a(Array)
    end
  end

  it "returns current weather data" do
    VCR.use_cassette('taunton_forecast') do
      get '/api/v1/forecast', params: {location: "taunton,ma" }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data][:attributes][:current_weather].keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
      expect(body[:data][:attributes][:current_weather][:datetime]).to be_a(String)
      expect(body[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
      expect(body[:data][:attributes][:current_weather][:sunset]).to be_a(String)
      expect(body[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(body[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(body[:data][:attributes][:current_weather][:humidity]).to be_a(Integer)
      expect(body[:data][:attributes][:current_weather][:uvi]).to be_a(Integer)
      expect(body[:data][:attributes][:current_weather][:visibility]).to be_a(Integer)
      expect(body[:data][:attributes][:current_weather][:conditions]).to be_a(String)
      expect(body[:data][:attributes][:current_weather][:icon]).to be_a(String)
    end
  end

  it "returns daily weather data" do
    VCR.use_cassette('taunton_forecast') do
      get '/api/v1/forecast', params: {location: "taunton,ma" }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data][:attributes][:daily_weather].size).to eq(5)
      expect(body[:data][:attributes][:daily_weather][0]).to be_a(Hash)
      expect(body[:data][:attributes][:daily_weather][0].keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon])
      expect(body[:data][:attributes][:daily_weather][0][:date]).to be_a(String)
      expect(body[:data][:attributes][:daily_weather][0][:sunrise]).to be_a(String)
      expect(body[:data][:attributes][:daily_weather][0][:sunset]).to be_a(String)
      expect(body[:data][:attributes][:daily_weather][0][:max_temp]).to be_a(Float)
      expect(body[:data][:attributes][:daily_weather][0][:min_temp]).to be_a(Float)
      expect(body[:data][:attributes][:daily_weather][0][:conditions]).to be_a(String)
      expect(body[:data][:attributes][:daily_weather][0][:icon]).to be_a(String)
    end
  end

  it "returns hourly weather data" do
    VCR.use_cassette('taunton_forecast') do
      get '/api/v1/forecast', params: {location: "taunton,ma" }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data][:attributes][:hourly_weather].size).to eq(8)
      expect(body[:data][:attributes][:hourly_weather][0]).to be_a(Hash)
      expect(body[:data][:attributes][:hourly_weather][0].keys).to eq([:time, :temperature, :conditions, :icon])
      expect(body[:data][:attributes][:hourly_weather][0][:time]).to be_a(String)
      expect(body[:data][:attributes][:hourly_weather][0][:temperature]).to be_a(Float)
      expect(body[:data][:attributes][:hourly_weather][0][:conditions]).to be_a(String)
      expect(body[:data][:attributes][:hourly_weather][0][:icon]).to be_a(String)
    end
  end

end
