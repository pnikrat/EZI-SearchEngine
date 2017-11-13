class AddStemAndTfIdfVectorToSearches < ActiveRecord::Migration[5.1]
  def change
    add_column :searches, :stem, :string
    add_column :searches, :tfidf_vector, :text
  end
end
