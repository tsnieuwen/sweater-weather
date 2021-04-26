class SalariesService

  def self.find_ua_id
    Faraday.get("https://api.teleport.org/api/urban_areas/")
  end

end
