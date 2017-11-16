class AddCosineSimilarityIndexToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_index :documents, :cosine_similarity
  end
end
