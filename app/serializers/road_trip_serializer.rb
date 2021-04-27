class RoadTripSerializer
  include FastJsonapi::ObjectSerializer

  attribute :start_city do |roadtrip|
    roadtrip.start_city
  end

  attribute :end_city do |roadtrip|
    roadtrip.end_city
  end

  attribute :travel_time do |roadtrip|
    roadtrip.travel_time
  end

  attribute :weather_at_eta do |roadtrip|
    roadtrip.weather_at_eta
  end

end
