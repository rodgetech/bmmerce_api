class Api::V1::ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at
    
  has_many :images

  class ImageSerializer < ActiveModel::Serializer
    attributes :id, :listing_image
  end
end
