class SalariesFacade

  def self.return(destination)
    body = SalariesService.hit_api
    city_array = body[:_links][:"ua:item"]
    link = self.find_urban_area(city_array, destination)
    require "pry"; binding.pry
  end

  def self.find_urban_area(city_array, destination)
    link = nil
    city_array.each do |hash|
      if hash[:name] == destination
        link = hash[:href]
      end
    end
    link
  end

end
