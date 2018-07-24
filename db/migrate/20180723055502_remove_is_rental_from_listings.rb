class RemoveIsRentalFromListings < ActiveRecord::Migration[5.1]
  def change
    remove_column :listings, :is_rental, :boolean
  end
end
