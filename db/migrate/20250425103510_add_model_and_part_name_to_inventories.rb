class AddModelAndPartNameToInventories < ActiveRecord::Migration[8.0]
  def change
    add_column :inventories, :model, :string
    add_column :inventories, :part_name, :string
  end
end
