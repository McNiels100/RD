class RenameSkuToSkuPrefix < ActiveRecord::Migration[8.0]
  change_table :items do |t|
    t.rename :sku, :sku_prefix
  end
end
