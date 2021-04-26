require 'rails_helper'

RSpec.describe SalariesFacade do
  describe "Methods" do

    it "::return" do
      expect(SalariesFacade.return("Denver")).to be_a(OpenStruct)
    end

    it "::forecast" do
      output = SalariesFacade.forecast("Denver")
      expect(output).to be_a(Hash)
      expect(output.keys).to eq([:summary, :temperature])
      expect(output[:summary]).to be_a(String)
      expect(output[:temperature]).to be_a(String)
    end

    it "::find_urban_area" do
      array = [{href: "example.com", name: "Denver"}]
      output = SalariesFacade.find_urban_area(array, "Denver")

      expect(output).to eq("example.com")
    end

    # it "::find_salaries_link" do
    #   body = {_links: {:"ua:salaries" {href: "hello"}}}
    #   output = SalariesFacade.find_salaries_link(body)
    #   expect(output).to eq("hello")
    # end

  end
end
