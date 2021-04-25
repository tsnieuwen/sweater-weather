require 'rails_helper'

describe "forecast return happy path" do

  it "returns forecast data per spec " do
    VCR.use_cassette('taunton_image') do
      get '/api/v1/image', params: {location: "taunton,ma" }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(body[:data][:attributes]).to have_key(:image)
      expect(body[:data][:attributes][:image]).to be_a(Hash)
      expect(body[:data][:attributes][:image].keys).to eq([:location, :image_url, :credit])
      expect(body[:data][:attributes][:image][:location]).to be_a(String)
      expect(body[:data][:attributes][:image][:image_url]).to be_a(String)
      expect(body[:data][:attributes][:image][:credit]).to be_a(Hash)
      expect(body[:data][:attributes][:image][:credit].keys).to eq([:source, :author])
      expect(body[:data][:attributes][:image][:credit][:source]).to be_a(String)
      expect(body[:data][:attributes][:image][:credit][:author]).to be_a(String)
    end
  end

end
