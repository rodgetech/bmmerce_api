class RemoveDistrictFromListings < ActiveRecord::Migration[5.1]
  def change
    remove_reference :listings, :district, foreign_key: true
  end
end
