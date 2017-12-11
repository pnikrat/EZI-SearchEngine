class CreateGroupingModes < ActiveRecord::Migration[5.1]
  def change
    create_table :grouping_modes do |t|
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
