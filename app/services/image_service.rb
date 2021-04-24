class ImageService

  def self.return_image_body(search)
    response = Faraday.get("https://api.unsplash.com/search/photos?client_id=#{ENV['unsplash_key']}&query=#{search} downtown&page=1&per_page=1&order_by=relevant")
    body = JSON.parse(response.body, symbolize_names: true)
  end

end
