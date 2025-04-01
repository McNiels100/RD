class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :sku
      t.text :description
      t.decimal :base_price
      t.string :category
      t.boolean :active

      t.timestamps
    end
  end
end
