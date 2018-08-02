class Account < ApplicationRecord
    mount_uploader :avatar, AvatarUploader
    has_secure_password
    
    has_many :listings
    belongs_to :business, optional: true
end
