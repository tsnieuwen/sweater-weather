require 'rails_helper'

describe "return happy path" do

  it "return happy path" do
      get '/api/v1/salaries', params: {destination: "Denver" }
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data].keys).to eq([:id, :type, :attributes])

      expect(body[:data][:id]).to eq(nil)
      expect(body[:data][:type]).to eq("salaries")

      expect(body[:data][:attributes]).to be_a(Hash)
      expect(body[:data][:attributes].keys).to eq([:destination, :forecast, :salaries])

      expect(body[:data][:attributes][:destination]).to be_a(String)

      expect(body[:data][:attributes][:forecast]).to be_a(Hash)
      expect(body[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(body[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(body[:data][:attributes][:forecast][:temperature]).to be_a(String)

      expect(body[:data][:attributes][:salaries]).to be_a(Array)
      expect(body[:data][:attributes][:salaries].size).to eq(7)

      expect(body[:data][:attributes][:salaries][0]).to be_a(Hash)
      expect(body[:data][:attributes][:salaries][0].keys).to eq([:title, :min, :max])
      expect(body[:data][:attributes][:salaries][0][:title]).to be_a(String)
      expect(body[:data][:attributes][:salaries][0][:min]).to be_a(String)
      expect(body[:data][:attributes][:salaries][0][:max]).to be_a(String)

      expect(body[:data][:attributes][:salaries][1]).to be_a(Hash)
      expect(body[:data][:attributes][:salaries][1].keys).to eq([:title, :min, :max])
      expect(body[:data][:attributes][:salaries][1][:title]).to be_a(String)
      expect(body[:data][:attributes][:salaries][1][:min]).to be_a(String)
      expect(body[:data][:attributes][:salaries][1][:max]).to be_a(String)

      expect(body[:data][:attributes][:salaries][2]).to be_a(Hash)
      expect(body[:data][:attributes][:salaries][2].keys).to eq([:title, :min, :max])
      expect(body[:data][:attributes][:salaries][2][:title]).to be_a(String)
      expect(body[:data][:attributes][:salaries][2][:min]).to be_a(String)
      expect(body[:data][:attributes][:salaries][2][:max]).to be_a(String)

      expect(body[:data][:attributes][:salaries][3]).to be_a(Hash)
      expect(body[:data][:attributes][:salaries][3].keys).to eq([:title, :min, :max])
      expect(body[:data][:attributes][:salaries][3][:title]).to be_a(String)
      expect(body[:data][:attributes][:salaries][3][:min]).to be_a(String)
      expect(body[:data][:attributes][:salaries][3][:max]).to be_a(String)

      expect(body[:data][:attributes][:salaries][4]).to be_a(Hash)
      expect(body[:data][:attributes][:salaries][4].keys).to eq([:title, :min, :max])
      expect(body[:data][:attributes][:salaries][4][:title]).to be_a(String)
      expect(body[:data][:attributes][:salaries][4][:min]).to be_a(String)
      expect(body[:data][:attributes][:salaries][4][:max]).to be_a(String)

      expect(body[:data][:attributes][:salaries][5]).to be_a(Hash)
      expect(body[:data][:attributes][:salaries][5].keys).to eq([:title, :min, :max])
      expect(body[:data][:attributes][:salaries][5][:title]).to be_a(String)
      expect(body[:data][:attributes][:salaries][5][:min]).to be_a(String)
      expect(body[:data][:attributes][:salaries][5][:max]).to be_a(String)

      expect(body[:data][:attributes][:salaries][6]).to be_a(Hash)
      expect(body[:data][:attributes][:salaries][6].keys).to eq([:title, :min, :max])
      expect(body[:data][:attributes][:salaries][6][:title]).to be_a(String)
      expect(body[:data][:attributes][:salaries][6][:min]).to be_a(String)
      expect(body[:data][:attributes][:salaries][6][:max]).to be_a(String)
  end


end
