class AddTitleIndexToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_index :documents, :title
  end
end
