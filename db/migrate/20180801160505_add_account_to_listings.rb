class AddAccountToListings < ActiveRecord::Migration[5.1]
  def change
    add_reference :listings, :account, foreign_key: true
  end
end
