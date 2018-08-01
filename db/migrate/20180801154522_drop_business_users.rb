class DropBusinessUsers < ActiveRecord::Migration[5.1]
  def change
    drop_table :business_users
  end
end
