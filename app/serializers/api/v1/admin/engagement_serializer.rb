class Api::V1::Admin::EngagementSerializer < ActiveModel::Serializer
    attributes :id, :listing, :created_at, :recipient_id, :sender_id

    belongs_to :listing
    belongs_to :recipient

    class ListingSerializer < ActiveModel::Serializer
        attributes :id, :title, :images
    end
end
  