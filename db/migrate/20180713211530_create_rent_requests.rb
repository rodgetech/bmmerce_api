class CreateRentRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :rent_requests do |t|
      t.string :name
      t.string :contact_number
      t.datetime :rent_date
      t.text :comment

      t.timestamps
    end
  end
end
