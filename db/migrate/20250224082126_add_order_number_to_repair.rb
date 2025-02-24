class AddOrderNumberToRepair < ActiveRecord::Migration[8.0]
  def change
    add_column :repairs, :order_number, :string
    add_index :repairs, :order_number, unique: true
  end
end
