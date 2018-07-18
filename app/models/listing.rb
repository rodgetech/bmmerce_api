class Listing < ApplicationRecord
    include PgSearch
    pg_search_scope :search, against: [:title], using: { tsearch: { prefix: true } }

    belongs_to :user, optional: true
    belongs_to :district
    has_many :images, dependent: :destroy
    has_many :rent_requests, dependent: :destroy

    validates_presence_of :title, :address, :contact_name, :contact_number, :contact_email
    validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
end
