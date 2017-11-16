class Document < ApplicationRecord
  scope :most_relevant, -> { all.order(cosine_similarity: :desc) }
  serialize :tfidf_vector, Array
end
