class Api::V1::BusinessSerializer < ActiveModel::Serializer
    attributes :id, :name, :address, :logo, :cover_image
  end
  