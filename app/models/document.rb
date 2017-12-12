class Document < ApplicationRecord
  scope :most_relevant, -> { all.order(cosine_similarity: :desc) }
  serialize :tfidf_vector, Array
  serialize :stemcount_vector, Array

  def self.alphabetical(offset = 0)
    order(title: :asc).offset(offset).all
  end
end
