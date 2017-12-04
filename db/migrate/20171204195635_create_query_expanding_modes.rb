class CreateQueryExpandingModes < ActiveRecord::Migration[5.1]
  def change
    create_table :query_expanding_modes do |t|
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
