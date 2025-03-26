class CreateRepairStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :repair_statuses do |t|
      t.references :repair, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
