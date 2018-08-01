class Business < ApplicationRecord
    geocoded_by :address
    after_validation :geocode
    has_many :listings
end
