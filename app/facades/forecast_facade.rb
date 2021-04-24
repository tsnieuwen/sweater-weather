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
    self.daily_weather(body)
    self.hourly_weather(body)
  end

  def self.current_weather(body)
    current_weather = body[:current]
    o = OpenStruct.new({
      datetime: Time.at(current_weather[:dt]).to_s,
      sunrise: Time.at(current_weather[:sunrise]).to_s,
      sunset: Time.at(current_weather[:sunset]).to_s,
      temperature: (1.8 * ((current_weather[:temp]) - 273.15) + 32).round(2),
      feels_like: (1.8 * ((current_weather[:feels_like]) - 273.15) + 32).round(2),
      humidity: current_weather[:humidity],
      uvi: current_weather[:uvi],
      visibility: current_weather[:visibility],
      conditions: current_weather[:weather][0][:description],
      icon: current_weather[:weather][0][:icon]
      })
  end

  def self.daily_weather(body)
    daily_weather = body[:daily][1..5]
    array = daily_weather.map do |day_weather|
      OpenStruct.new({
        date: Time.at(day_weather[:dt]).strftime('%F'),
        sunrise: Time.at(day_weather[:sunrise]).to_s,
        sunset: Time.at(day_weather[:sunset]).to_s,
        max_temp: (1.8 * ((day_weather[:temp][:max]) - 273.15) + 32).round(2),
        min_temp: (1.8 * ((day_weather[:temp][:min]) - 273.15) + 32).round(2),
        conditions: day_weather[:weather][0][:description],
        icon: day_weather[:weather][0][:icon]
        })
    end
  end

  def self.hourly_weather(body)
    hourly_weather = body[:hourly][1..8]
    array = hourly_weather.map do |hour_weather|
      OpenStruct.new({
        time: Time.at(hour_weather[:dt]).strftime('%T'),
        temperature: (1.8 * ((hour_weather[:temp]) - 273.15) + 32).round(2),
        conditions: hour_weather[:weather][0][:description],
        icon: hour_weather[:weather][0][:icon]
        })
    end
  end

end
