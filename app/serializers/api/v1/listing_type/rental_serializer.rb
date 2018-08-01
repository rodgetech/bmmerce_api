class Api::V1::ListingType::RentalSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :is_rental, :price,
    :user_id, :address, :created_at, :latitude, :longitude
    
  has_many :images
  belongs_to :user  

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name
  end

  class ImageSerializer < ActiveModel::Serializer
    attributes :id, :listing_image
  end
end
