class RentRequest < ApplicationRecord
    belongs_to :listing
    validates_presence_of :name, :contact_number, :comment
end
