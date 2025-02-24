class CreateDevices < ActiveRecord::Migration[8.0]
  def change
    create_table :devices do |t|
      t.string :brand
      t.string :device_type
      t.integer :TAT_neutral
      t.integer :TAT_unsatisfied
      t.integer :TAT_very_unsatisfied

      t.timestamps
    end
  end
end
