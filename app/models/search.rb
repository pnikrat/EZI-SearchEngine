require 'stemmify'

class Search < ApplicationRecord
  serialize :tfidf_vector, Array
  belongs_to :origin_search, class_name: 'Search',
                             foreign_key: 'search_id', optional: true
  has_many :similar_searches, class_name: 'Search'

  def find_results
    stemmify_query
    TfIdfService.new.call(self)
    CosineSimilarityService.new(self).call
    return unless QueryExpandingMode.active?
    proposed_words = CMatrixService.new(self).call
    return if proposed_words.nil?
    create_similar_searches(proposed_words)
  end

  private

  def stemmify_query
    update(stem: query.split(' ').map(&:stem).join(' '))
  end

  def create_similar_searches(proposed_words)
    proposed_words.each do |word|
      similar_searches.create(query: query + ' ' + word)
    end
  end
end
