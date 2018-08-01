class RemoveUserFromListings < ActiveRecord::Migration[5.1]
  def change
    remove_reference :listings, :user, foreign_key: true
  end
end
