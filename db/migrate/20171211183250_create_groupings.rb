class CreateGroupings < ActiveRecord::Migration[5.1]
  def change
    create_table :groupings do |t|
      t.integer :number_of_groups
      t.float :minimum_similarity
      t.boolean :similarity_stop_condition

      t.timestamps
    end
  end
end
