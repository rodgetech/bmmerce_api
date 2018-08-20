class AddPlayerIdToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :player_id, :string
    add_index :accounts, :player_id
  end
end
