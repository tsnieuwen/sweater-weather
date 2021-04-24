class ForecastFacade

  def self.coordinate_digest(location)
    response = Faraday.get("http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['mapquest_key']}&location=#{location}")
    body = JSON.parse(response.body, symbolize_names: true)
    lat = body[:results][0][:locations][0][:latLng][:lat]
    long = body[:results][0][:locations][0][:latLng][:lng]
    self.return_weather(lat, long)
  end

  def self.return_weather(x, y)
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall?lat=#{x}&lon=#{y}&appid=#{ENV['open_weather_key']}&exclude=minutely,alerts")
    body = JSON.parse(response.body, symbolize_names: true)
    self.current_weather(body)
  end

  def self.current_weather(body)
    current_weather = body[:current]
    OpenStruct.new({
      datetime: current_weather[:dt],
      sunrise: current_weather[:sunrise],
      sunset: current_weather[:sunset],
      temperature: (1.8 * ((current_weather[:temp]) - 273.15) + 32).round(2),
      feels_like: (1.8 * ((current_weather[:feels_like]) - 273.15) + 32).round(2),
      humidity: current_weather[:humidity],
      uvi: current_weather[:uvi],
      visibility: current_weather[:visibility],
      conditions: current_weather[:weather][0][:description],
      icon: current_weather[:weather][0][:icon]
      })
  end

end
