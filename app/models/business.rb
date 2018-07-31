class Business < ApplicationRecord
    has_many :business_users, dependent: :destroy
end
