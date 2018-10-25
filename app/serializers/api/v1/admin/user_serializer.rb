class Api::V1::Admin::UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :avatar, :password_digest, :address

    def password_digest
        ""
    end

    def avatar
        if object.avatar.url 
            object.avatar.url
        elsif object.provider_image
            object.provider_image
        else
            "https://res.cloudinary.com/bmmerce/image/upload/v1540489328/avatar-placeholder.png"
        end
    end
end  