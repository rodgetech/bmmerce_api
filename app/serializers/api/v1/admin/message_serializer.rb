class Api::V1::Admin::MessageSerializer < ActiveModel::Serializer
    attributes :id, :body, :read, :engagement_id, :account_id, :recipient_id, :created_at

    belongs_to :account
    belongs_to :engagement

    class UserSerializer < ActiveModel::Serializer
        attributes :id, :name, :avatar
    end

    class EngagementSerializer < ActiveModel::Serializer
        attributes :listing_id
    end
end
  