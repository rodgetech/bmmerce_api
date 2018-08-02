class Api::V1::Admin::UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :avatar, :password_digest

    def password_digest
        ""
    end
end  