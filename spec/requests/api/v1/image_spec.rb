require 'rails_helper'

describe "Response to image call" do

  it "searches for all items based on search param that matches item name or description" do

    get '/api/v1/image', params: {location: "taunton,ma" }
    expect(response).to be_successful

  end

end
