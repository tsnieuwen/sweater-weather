class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attribute :current_weather do |forecast|
    forecast.current_weather
  end

  attribute :daily_weather do |forecast|
    forecast.daily_weather
  end

  attribute :hourly_weather  do |forecast|
    forecast.hourly_weather
  end
  
end
