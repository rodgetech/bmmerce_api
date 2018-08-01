class Listing < ApplicationRecord
    include PgSearch
    pg_search_scope :search, against: [:title], using: { tsearch: { prefix: true } }

    geocoded_by :address
    after_validation :geocode

    belongs_to :account
    belongs_to :business, optional: true
    has_many :images, dependent: :destroy

    validates_presence_of :title, :address
    validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
end
