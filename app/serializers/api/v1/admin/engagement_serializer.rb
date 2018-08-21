class Api::V1::Admin::EngagementSerializer < ActiveModel::Serializer
    attributes :id, :listing, :created_at, :recipient_id, :sender_id, :unread_messages_count

    belongs_to :listing
    belongs_to :recipient

    def unread_messages_count 
        object.messages.where(recipient_id: @instance_options[:current_account_id], read: false).count
    end

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
  