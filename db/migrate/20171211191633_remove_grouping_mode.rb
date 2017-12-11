class RemoveGroupingMode < ActiveRecord::Migration[5.1]
  def change
    drop_table :grouping_modes
  end
end
