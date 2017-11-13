class AddCosineSimilarityToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :cosine_similarity, :float
  end
end
