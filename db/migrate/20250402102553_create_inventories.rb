class CreateInventories < ActiveRecord::Migration[8.0]
  def change
      create_table :inventories do |t|
        t.references :item, null: false, foreign_key: true # Reference to item's general information
        t.string :location, null: false  # Physical location/storage
        t.integer :imei, index: true
        t.string :serial, index: true    # Added index for faster lookup
        t.references :created_by_user, foreign_key: { to_table: :users }  # Better than string
        t.references :used_by_user, foreign_key: { to_table: :users }     # Tracks who used the item
        t.references :repair, foreign_key: true  # Changed to optional (null: true) because it must not be linked to repair if not used
        t.string :sku, index: true       # Added index for stock keeping unit
        t.string :status, default: 'in_stock'  # Added status tracking
        t.datetime :used_at              # When item was used

        t.timestamps
      end

      add_index :inventories, [ :imei, :serial ], unique: true  # Ensure unique identifiers
    end
end
