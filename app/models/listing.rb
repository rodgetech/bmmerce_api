class Listing < ApplicationRecord
    include PgSearch
    pg_search_scope :search, against: [:title], using: { tsearch: { prefix: true } }

    geocoded_by :address

    belongs_to :user, optional: true
    belongs_to :district, optional: true
    has_many :images, dependent: :destroy
    has_many :rent_requests, dependent: :destroy

    validates_presence_of :title, :address, :contact_number
    validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
end
