class Api::V1::ListingSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :price_details,
    :user_id, :address
  has_many :images
end
