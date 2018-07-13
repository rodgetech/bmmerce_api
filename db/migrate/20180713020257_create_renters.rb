class CreateRenters < ActiveRecord::Migration[5.1]
  def change
    create_table :renters do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :contact_number

      t.timestamps
    end
    add_index :renters, :email, unique: true
  end
end
