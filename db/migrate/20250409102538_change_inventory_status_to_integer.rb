class ChangeInventoryStatusToInteger < ActiveRecord::Migration[8.0]
  # Define a temporary model scoped to this migration
  class MigrationInventory < ApplicationRecord
    self.table_name = :inventories
  end

  def change
    status_mapping = {
      "in_stock" => 0,
      "allocated_repair" => 1
    }

    add_column :inventories, :status_integer, :integer

    MigrationInventory.reset_column_information
    MigrationInventory.find_each do |inventory|
      original_status_string = inventory.read_attribute_before_type_cast(:status)

      integer_value = status_mapping[original_status_string]

      inventory.update_column(:status_integer, integer_value) if integer_value.present?
    end

    remove_column :inventories, :status, :string

    rename_column :inventories, :status_integer, :status

    change_column_default :inventories, :status, 0

    add_index :inventories, :status
  end
end
