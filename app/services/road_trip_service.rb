class RoadTripService

  def self.directions(origin, destination)
    response = Faraday.get("http://www.mapquestapi.com/directions/v2/route?key=#{ENV['mapquest_key']}&from=#{origin}&to=#{destination}")
    body = JSON.parse(response.body, symbolize_names: true)
    if body[:info][:messages][0] == "We are unable to route with the given locations."
      "We are unable to route with the given locations."
    elsif body[:route][:locations][0][:geocodeQualityCode] == "A1XAX" || body[:route][:locations][1][:geocodeQualityCode] == "A1XAX"
      nil
    else
      body
    end
  end
end
