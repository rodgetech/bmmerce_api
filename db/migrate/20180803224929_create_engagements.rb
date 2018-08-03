class CreateEngagements < ActiveRecord::Migration[5.1]
  def change
    create_table :engagements do |t|
      t.references :listing, foreign_key: true
      t.references :business, foreign_key: true
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
