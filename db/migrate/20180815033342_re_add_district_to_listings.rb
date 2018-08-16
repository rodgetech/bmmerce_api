class ReAddDistrictToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :district, :string
    add_index :listings, :district
  end
end
