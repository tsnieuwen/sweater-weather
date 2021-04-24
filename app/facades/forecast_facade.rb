class ForecastFacade

  def self.return_forecasts(location)
    body = ForecastService.coordinate_digest(location)
    OpenStruct.new({
      forecast: self.current_weather(body),
      daily_weather: self.daily_weather(body),
      hourly_weather: self.hourly_weather(body)
      })
  end

  def self.current_weather(body)
    current_weather = body[:current]
    OpenStruct.new({
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
