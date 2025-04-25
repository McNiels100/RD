class RemoveDescriptionFromInventories < ActiveRecord::Migration[8.0]
  def change
    remove_column :inventories, :description, :text
  end
end
