class AddImeiAndSerialToRepairItems < ActiveRecord::Migration[8.0]
  def change
    add_column :repair_items, :imei, :integer
    add_column :repair_items, :serial, :string
  end
end
