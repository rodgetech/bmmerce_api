class AddDistrictToListings < ActiveRecord::Migration[5.1]
  def change
    add_reference :listings, :district, foreign_key: true
  end
end
