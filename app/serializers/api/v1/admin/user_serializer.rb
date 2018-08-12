class Api::V1::Admin::UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :avatar, :password_digest

    def password_digest
        ""
    end

    def avatar
        if object.avatar.url 
            object.avatar
        elsif object.provider_image
            object.provider_image
        else
            "https://res.cloudinary.com/dwaavflqp/image/upload/v1534114081/avatar-placeholder_vscerq.png"
        end
    end
end  