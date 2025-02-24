class AddDeviceTypeToRepair < ActiveRecord::Migration[8.0]
  def change
    add_column :repairs, :device_type, :string
  end
end
