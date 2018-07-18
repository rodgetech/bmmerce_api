class AddFlagsToListings < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :email_flag, :boolean, default: true
    add_column :listings, :phone_call_flag, :boolean, default: true
    add_column :listings, :sms_flag, :boolean, default: true
    add_column :listings, :whatsapp_flag, :boolean, default: true
  end
end
