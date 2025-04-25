class AddModelCodeToRepairs < ActiveRecord::Migration[8.0]
  def change
    add_column :repairs, :model_code, :string
  end
end
