class RoadTripService

  def self.directions(origin, destination)
    response = Faraday.get("http://www.mapquestapi.com/directions/v2/route?key=#{ENV['mapquest_key']}&from=#{origin}&to=#{destination}")
    body = JSON.parse(response.body, symbolize_names: true)
  end

end
