class CreateRepairs < ActiveRecord::Migration[8.0]
  def change
    create_table :repairs do |t|
      t.string :name
      t.string :email
      t.integer :phone_number
      t.string :brand
      t.text :error_description
      t.integer :imei
      t.string :serial
      t.string :model

      t.timestamps
    end
  end
end
