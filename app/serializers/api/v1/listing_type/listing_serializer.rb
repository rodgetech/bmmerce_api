class Api::V1::ListingType::ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :is_rental, :price,
    :account_id, :address, :district, :created_at, :latitude, :longitude
    
  has_many :images
  belongs_to :account 
  belongs_to :business 

  class AccountSerializer < ActiveModel::Serializer
    attributes :id, :name, :avatar
    def avatar
      if object.avatar.url 
          object.avatar.url
      elsif object.provider_image
          object.provider_image
      else
          "https://res.cloudinary.com/dwaavflqp/image/upload/v1534114081/avatar-placeholder_vscerq.png"
      end
    end
  end

  class BusinessSerializer < ActiveModel::Serializer
    attributes :id, :name
  end

  class ImageSerializer < ActiveModel::Serializer
    attributes :id, :listing_image
  end
end
