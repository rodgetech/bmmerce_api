class AddBusinessToListings < ActiveRecord::Migration[5.1]
  def change
    add_reference :listings, :business, foreign_key: true
  end
end
