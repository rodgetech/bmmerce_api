class AddIndexToEngagements < ActiveRecord::Migration[5.1]
  def change
    add_index :engagements, :recipient_id
    add_index :engagements, :sender_id
  end
end
