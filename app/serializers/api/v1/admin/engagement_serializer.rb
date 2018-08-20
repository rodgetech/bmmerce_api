class Api::V1::Admin::EngagementSerializer < ActiveModel::Serializer
    attributes :id, :listing, :created_at, :recipient_id, :sender_id

    belongs_to :listing
    belongs_to :recipient

    class ListingSerializer < ActiveModel::Serializer
        attributes :id, :title, :images, :price
    end

    class UserSerializer < ActiveModel::Serializer
        attributes :id, :name, :email, :avatar

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
end
  