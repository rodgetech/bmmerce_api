class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :engagement, foreign_key: true
      t.references :account, foreign_key: true
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
