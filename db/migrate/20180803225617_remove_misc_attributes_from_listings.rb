class RemoveMiscAttributesFromListings < ActiveRecord::Migration[5.1]
  def change
    remove_column :listings, :price_details, :text
    remove_column :listings, :contact_name, :string
    remove_column :listings, :contact_email, :string
    remove_column :listings, :contact_number, :string
    remove_column :listings, :email_flag, :boolean
    remove_column :listings, :phone_call_flag, :boolean
    remove_column :listings, :sms_flag, :boolean
    remove_column :listings, :whatsapp_flag, :boolean


  end
end
