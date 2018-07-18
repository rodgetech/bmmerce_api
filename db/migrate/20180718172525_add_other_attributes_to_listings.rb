class AddOtherAttributesToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :contact_name, :string
    add_column :listings, :contact_email, :string
    add_column :listings, :contact_number, :string
  end
end
