class CreateTerms < ActiveRecord::Migration[5.1]
  def change
    create_table :terms do |t|
      t.string :full
      t.string :stem

      t.timestamps
    end
  end
end
