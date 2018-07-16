class Image < ApplicationRecord
  belongs_to :listing
  mount_uploader :listing_image, ListingUploader
end
