class SalariesSerializer
  include FastJsonapi::ObjectSerializer

  attribute :destination do |salary|
    salary.destination
  end

  attribute :forecast do |salary|
    salary.forecast
  end

  attribute :salaries  do |salary|
    salary.salaries
  end

end
