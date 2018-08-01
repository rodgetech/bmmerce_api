class DropDistricts < ActiveRecord::Migration[5.1]
  def change
    drop_table :districts
  end
end
