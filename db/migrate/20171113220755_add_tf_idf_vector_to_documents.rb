class AddTfIdfVectorToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :tfidf_vector, :text
  end
end
