class AddUidToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :uid, :string
    add_index :accounts, :uid, unique: true
  end
end
