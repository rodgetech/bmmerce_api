class DropRentRequests < ActiveRecord::Migration[5.1]
  def change
    drop_table :rent_requests
  end
end
