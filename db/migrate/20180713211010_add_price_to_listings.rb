class AddPriceToListings < ActiveRecord::Migration[5.1]
  def change
    add_monetize :listings, :price
  end
end
