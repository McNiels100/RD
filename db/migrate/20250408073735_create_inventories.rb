class CreateInventories < ActiveRecord::Migration[8.0]
  def change
    create_table :inventories do |t|
      t.integer :imei
      t.string :serial
      t.string :location
      t.string :status, default: 'in_stock'
      t.references :repair, foreign_key: true

      t.timestamps
    end
  end
end
