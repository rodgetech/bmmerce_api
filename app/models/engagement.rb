class Engagement < ApplicationRecord
  belongs_to :listing, optional: true
  belongs_to :business, optional: true
end
