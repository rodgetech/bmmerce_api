class AddPriceDetailsToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :price_details, :text
  end
end
