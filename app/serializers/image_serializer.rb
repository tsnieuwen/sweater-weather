class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :image do |image|
    image.image_data
  end
end
