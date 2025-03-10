class AddLockingToRepairs < ActiveRecord::Migration[8.0]
  def change
    add_column :repairs, :locked_by, :string
    add_column :repairs, :locked_at, :datetime
  end
end
