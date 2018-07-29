class Api::V1::ListingType::ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :is_rental, :price,
    :user_id, :address, :contact_name, :contact_email,
    :contact_number, :email_flag, :sms_flag, :phone_call_flag,
    :whatsapp_flag, :created_at, :latitude, :longitude
    
  has_many :images
  belongs_to :user  

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name
  end

  class ImageSerializer < ActiveModel::Serializer
    attributes :id, :listing_image
  end
end
