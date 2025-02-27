class RenameTatColumnNames < ActiveRecord::Migration[8.0]
  def change
    rename_column :Devices, :TAT_neutral, :tat_neutral
    rename_column :Devices, :TAT_unsatisfied, :tat_unsatisfied
    rename_column :Devices, :TAT_very_unsatisfied, :tat_very_unsatisfied
  end
end
