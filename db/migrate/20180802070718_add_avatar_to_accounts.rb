class AddAvatarToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :avatar, :string
  end
end
