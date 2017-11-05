class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :body
      t.text :stem

      t.timestamps
    end
  end
end
