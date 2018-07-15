class AddUpdatedPriceToListings < ActiveRecord::Migration[5.1]
  def change
    # precision is the total number of digits
    # scale is the number of digits to the right of the decimal point
    add_column :listings, :price, :decimal, :precision => 8, :scale => 2
  end
end
