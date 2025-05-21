class AddPartNumberToInventories < ActiveRecord::Migration[8.0]
  def change
    add_column :inventories, :part_number, :string
  end
end
