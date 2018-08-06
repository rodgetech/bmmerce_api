class Api::V1::Admin::MessageSerializer < ActiveModel::Serializer
    attributes :id, :body, :read, :created_at

    belongs_to :account

    class UserSerializer < ActiveModel::Serializer
        attributes :id, :name, :avatar
    end
end
  