require 'rails_helper'

describe "forecast return happy path" do

  it "returns forecast data per spec " do
    VCR.use_cassette('taunton_forecast') do
      get '/api/v1/forecast', params: {location: "taunton,ma" }
      expect(response).to be_successful
    end 
  end

end
