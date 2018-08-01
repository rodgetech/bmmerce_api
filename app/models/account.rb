class Account < ApplicationRecord
    has_secure_password
    has_many :listings
    belongs_to :business, optional: true
end
