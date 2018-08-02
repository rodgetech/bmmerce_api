class Api::V1::Admin::BusinessSerializer < ActiveModel::Serializer
    attributes :id, :name, :address
  end
  