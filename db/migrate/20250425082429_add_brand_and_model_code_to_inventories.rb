class AddBrandAndModelCodeToInventories < ActiveRecord::Migration[8.0]
  def change
    add_column :inventories, :brand, :string
    add_column :inventories, :model_code, :string
  end
end
