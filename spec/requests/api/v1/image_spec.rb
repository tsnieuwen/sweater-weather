require 'rails_helper'

describe "forecast return happy path" do

  it "returns forecast data per spec " do
      get '/api/v1/image', params: {location: "taunton,ma" }
      expect(response).to be_successful
  end

end
