class AddAddressToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :latitude, :float
    add_index :accounts, :latitude
    add_column :accounts, :longitude, :float
    add_index :accounts, :longitude
  end
end
