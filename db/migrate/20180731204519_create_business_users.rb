class CreateBusinessUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :business_users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :business_users, :email, unique: true
  end
end
