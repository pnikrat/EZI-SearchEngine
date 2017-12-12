class AddReferenceToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_reference :documents, :document_group, foreign_key: true
  end
end
