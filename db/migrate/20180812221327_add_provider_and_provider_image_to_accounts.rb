class AddProviderAndProviderImageToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :provider, :string
    add_index :accounts, :provider
    add_column :accounts, :provider_image, :string
  end
end
