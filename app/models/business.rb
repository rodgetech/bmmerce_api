class Business < ApplicationRecord
    mount_uploader :logo, BusinessUploader
    mount_uploader :cover_image, BusinessUploader

    geocoded_by :address
    after_validation :geocode
    has_many :listings
end
