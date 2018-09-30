class Listing < ApplicationRecord
    include PgSearch
    pg_search_scope :search, against: [:title], using: { tsearch: { prefix: true } }

    reverse_geocoded_by :latitude, :longitude

    belongs_to :account
    belongs_to :business, optional: true
    has_many :images, dependent: :destroy
    has_many :engagements, dependent: :destroy

    validates_presence_of :title
    validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
end
