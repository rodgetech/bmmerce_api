class AddCoverImageToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :cover_image, :string
  end
end
