class ForecastService

  def self.coordinate_digest(location)
    response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_key']}&location=#{location}")
    body = JSON.parse(response.body, symbolize_names: true)
    lat = body[:results][0][:locations][0][:latLng][:lat]
    long = body[:results][0][:locations][0][:latLng][:lng]
    if lat == 39.390897 && long == -99.066067
      nil
    else
      self.return_weather(lat, long)
    end
  end

  def self.return_weather(x, y)
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{x}&lon=#{y}&appid=#{ENV['open_weather_key']}&exclude=minutely,alerts")
    body = JSON.parse(response.body, symbolize_names: true)
  end

end
