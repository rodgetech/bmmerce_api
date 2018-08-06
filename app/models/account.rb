class Account < ApplicationRecord
    mount_uploader :avatar, AvatarUploader
    has_secure_password
    
    belongs_to :business, optional: true
    has_many :listings
    has_many :engagements, foreign_key: :sender_id

    # def engagements
    #     Engagement.where(sender_id: self.id).or(Engagement.where(recipient_id: self.id))
    # end
end
