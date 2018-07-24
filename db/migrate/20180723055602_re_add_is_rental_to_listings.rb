class ReAddIsRentalToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :is_rental, :boolean, default: false
  end
end
