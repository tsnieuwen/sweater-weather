class SalariesService

  def self.hit_api
    response = Faraday.get("https://api.teleport.org/api/urban_areas/")
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def self.hit_api_slug(link)
    response = Faraday.get(link)
    body = JSON.parse(response.body, symbolize_names: true)
  end

  def self.hit_api_salaries(link)
    response = Faraday.get(link)
    body = JSON.parse(response.body, symbolize_names: true)
  end

end
