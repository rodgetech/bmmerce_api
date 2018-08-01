class Api::V1::Admin::ListingSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :is_rental, :price,
      :account_id, :address, :created_at, :latitude, :longitude
      
    has_many :images
    belongs_to :account  
  
    class AccountSerializer < ActiveModel::Serializer
      attributes :id, :name
    end
  
    class ImageSerializer < ActiveModel::Serializer
      attributes :id, :listing_image
    end
  end
  