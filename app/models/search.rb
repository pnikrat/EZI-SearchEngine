require 'stemmify'

class Search < ApplicationRecord
  serialize :tfidf_vector, Array

  def find_results
    stemmify_query
    TfIdfService.new.call(self)
    CosineSimilarityService.new(self).call
    return unless QueryExpandingMode.active?
    CMatrixService.new(self).call
  end

  private

  def stemmify_query
    update(stem: query.split(' ').map(&:stem).join(' '))
  end
end
