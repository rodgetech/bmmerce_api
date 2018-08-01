class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :password_digest
      t.string :email
      t.string :username
      t.string :type

      t.timestamps
    end
    add_index :accounts, :email, unique: true
    add_index :accounts, :username, unique: true
  end
end
