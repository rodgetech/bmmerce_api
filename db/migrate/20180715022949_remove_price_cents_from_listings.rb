class RemovePriceCentsFromListings < ActiveRecord::Migration[5.1]
  def change
    remove_column :listings, :price_cents, :integer
    remove_column :listings, :price_currency, :string
  end
end
