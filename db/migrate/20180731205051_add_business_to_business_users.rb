class AddBusinessToBusinessUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :business_users, :business, foreign_key: true
  end
end
