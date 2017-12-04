class Document < ApplicationRecord
  scope :most_relevant, -> { all.order(cosine_similarity: :desc) }
  scope :alphabetical, -> { all.order(title: :asc) }
  serialize :tfidf_vector, Array
  serialize :stemcount_vector, Array
end
