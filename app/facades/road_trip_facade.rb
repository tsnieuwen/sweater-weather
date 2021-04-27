class RoadTripFacade

  def self.return(origin, destination)
    body = RoadTripService.directions(origin, destination)
    arrival_time = self.arrival_time(body)
    forecast = RoadTripFacade.destination_forecast(destination)
    o = OpenStruct.new({
      id: nil,
      start_city: origin,
      end_city: destination,
      travel_time: self.formatted_travel_time(body),
      weather_at_eta: self.weather_call(body, forecast)
      })
  end

  def self.trip_time_seconds(body)
    body[:route][:realTime]
  end

  def self.formatted_travel_time(body)
    original_seconds = self.trip_time_seconds(body)
    hours = original_seconds / 3600
    seconds = original_seconds - (hours * 3600)
    minutes = seconds / 60
    if original_seconds >= 3600
      "#{hours} hours, #{minutes} minutes"
    else
      "#{minutes} minutes"
    end
  end

  def self.arrival_time(body)
    arrival_time = Time.now + self.trip_time_seconds(body)
    arrival_time.beginning_of_hour.to_i
  end

  def self.weather_call(body, forecast)
    arrival_time = self.arrival_time(body)
    trip_time = arrival_time - Time.now.to_i
    if trip_time <= 3599
      self.current_weather_call(forecast)
    elsif trip_time <= 172799
      self.hourly_weather_call(forecast, arrival_time)
    elsif trip_time <= 604800
      reformatted_arrival_time = (Time.at(arrival_time).beginning_of_day + 50400).to_i
      self.daily_weather_call(forecast, reformatted_arrival_time)
    else
      "We're sorry, the forecast for your ETA is not available"
    end
  end

  def self.destination_forecast(destination)
    body = ForecastService.coordinate_digest(destination)
  end

  def self.current_weather_call(forecast)
    hash = Hash.new
    hash[:temperature] = (1.8 * ((forecast[:current][:temp]) - 273.15) + 32).round(2)
    hash[:conditions] = forecast[:current][:weather][0][:description]
    hash
  end

  def self.hourly_weather_call(forecast, arrival_time)
    hash = Hash.new
    forecast[:hourly].each do |hour_weather_hash|
      if hour_weather_hash[:dt] == arrival_time
        hash[:temperature] = (1.8 * ((hour_weather_hash[:temp]) - 273.15) + 32).round(2)
        hash[:conditions] = hour_weather_hash[:weather][0][:description]
      end
    end
    hash
  end

  def self.daily_weather_call(forecast, reformatted_arrival_time)
    hash = Hash.new
    forecast[:daily].each do |daily_weather_hash|
      if daily_weather_hash[:dt] == reformatted_arrival_time
        hash[:temperature] = (1.8 * ((daily_weather_hash[:temp][:day]) - 273.15) + 32).round(2)
        hash[:conditions] = daily_weather_hash[:weather][0][:description]
      end
    end
    hash
  end

end

#begin
  # def self.trip_time
#end
