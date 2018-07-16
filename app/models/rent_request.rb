class RentRequest < ApplicationRecord
    belongs_to :listing
    validates_presence_of :name, :contact_number, :rent_date, :comment
end
