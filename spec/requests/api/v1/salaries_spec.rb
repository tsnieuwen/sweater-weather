require 'rails_helper'

describe "return happy path" do

  it "return happy path" do
      get '/api/v1/salaries', params: {destination: "Denver" }
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)

      # expect(body[:data][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
      #
      # expect(body[:data][:attributes][:current_weather]).to be_a(Hash)
      # expect(body[:data][:attributes][:daily_weather]).to be_a(Array)
      # expect(body[:data][:attributes][:hourly_weather]).to be_a(Array)
  end


end
