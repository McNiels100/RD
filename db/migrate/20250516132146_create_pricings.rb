class CreatePricings < ActiveRecord::Migration[8.0]
  def change
     create_table :pricings do |t|
       t.string :part_number, null: false
       t.decimal :price, precision: 10, scale: 2, null: false
       t.date :effective_date, null: false

       t.timestamps
     end

     add_index :pricings, :part_number
     add_index :pricings, [ :part_number, :effective_date ]
   end
end
