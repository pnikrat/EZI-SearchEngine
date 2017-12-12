class CreateDocumentGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :document_groups do |t|

      t.timestamps
    end
  end
end
