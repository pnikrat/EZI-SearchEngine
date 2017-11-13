class Document < ApplicationRecord
  serialize :tfidf_vector, Array
end
