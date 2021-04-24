class ImageFacade

  def self.return_image(search)
    body = ImageService.return_image_body(search)
    o = OpenStruct.new({
      id: nil,
      image_data: self.hash(body, search)
      })
  end

  # def self.url(body)
  #   body[:results][0][:urls][:raw]
  # end
  #
  # def self.credit(body)
  #   hash = Hash.new
  #   hash[:source] = "unsplash.com"
  #   hash[:author] = body[:results][0][:user][:username]
  #   hash
  # end

  def self.hash(body, location)
    image_hash = Hash.new
    image_hash[:location] = "#{location}"
    image_hash[:image_url] = body[:results][0][:urls][:raw]
    image_hash[:credit] = self.credits(body)
    image_hash
  end

  def self.credits(body)
    hash = Hash.new
    hash[:source] = "unsplash.com"
    hash[:author] = body[:results][0][:user][:username]
    hash
  end

end
