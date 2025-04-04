class CreateRepairItems < ActiveRecord::Migration[8.0]
  def change
    create_table :repair_items do |t|
      t.references :repair, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price
      t.references :inventory, null: false, foreign_key: true
      t.text :notes
      t.text :description

      t.timestamps
    end
  end
end
