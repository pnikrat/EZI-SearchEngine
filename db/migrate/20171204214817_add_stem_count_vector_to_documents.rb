class AddStemCountVectorToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :stemcount_vector, :text
  end
end
