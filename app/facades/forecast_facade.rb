class ForecastFacade

  def self.return_forecasts(location)
    body = ForecastService.coordinate_digest(location)
    o = OpenStruct.new({
      id: nil,
      current_weather: self.current_weather(body),
      daily_weather: self.daily_weather(body),
      hourly_weather: self.hourly_weather(body)
      })
  end

  def self.current_weather(body)
    weather_now = body[:current]
    current_weather_hash = Hash.new
    current_weather_hash[:datetime] = Time.at(weather_now[:dt]).to_s
    current_weather_hash[:sunrise] = Time.at(weather_now[:sunrise]).to_s
    current_weather_hash[:sunset] = Time.at(weather_now[:sunset]).to_s
    current_weather_hash[:temperature] = (1.8 * ((weather_now[:temp]) - 273.15) + 32).round(2)
    current_weather_hash[:feels_like] = (1.8 * ((weather_now[:feels_like]) - 273.15) + 32).round(2)
    current_weather_hash[:humidity] = weather_now[:humidity]
    current_weather_hash[:uvi] = weather_now[:uvi]
    current_weather_hash[:visibility] = weather_now[:visibility]
    current_weather_hash[:conditions] = weather_now[:weather][0][:description]
    current_weather_hash[:icon] = weather_now[:weather][0][:icon]
    current_weather_hash
  end

  def self.daily_weather(body)
    daily_weather = body[:daily][1..5]
    array = daily_weather.map do |day_weather|
      daily_weather_hash = Hash.new
        daily_weather_hash[:date] = Time.at(day_weather[:dt]).strftime('%F')
        daily_weather_hash[:sunrise] = Time.at(day_weather[:sunrise]).to_s
        daily_weather_hash[:sunset] = Time.at(day_weather[:sunset]).to_s
        daily_weather_hash[:max_temp] = (1.8 * ((day_weather[:temp][:max]) - 273.15) + 32).round(2)
        daily_weather_hash[:min_temp] = (1.8 * ((day_weather[:temp][:min]) - 273.15) + 32).round(2)
        daily_weather_hash[:conditions] = day_weather[:weather][0][:description]
        daily_weather_hash[:icon] = day_weather[:weather][0][:icon]
      daily_weather_hash
    end
  end

  def self.hourly_weather(body)
    hourly_weather = body[:hourly][1..8]
    array = hourly_weather.map do |hour_weather|
      hourly_weather_hash = Hash.new
        hourly_weather_hash[:time] = Time.at(hour_weather[:dt]).strftime('%T')
        hourly_weather_hash[:temperature] =  (1.8 * ((hour_weather[:temp]) - 273.15) + 32).round(2)
        hourly_weather_hash[:conditions] = hour_weather[:weather][0][:description]
        hourly_weather_hash[:icon] = hour_weather[:weather][0][:icon]
      hourly_weather_hash
    end
  end

end
