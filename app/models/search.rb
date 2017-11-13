require 'stemmify'

class Search < ApplicationRecord
  def find_results
    stemmify_query
    TfIdfService.new.call(self)
    # develop cosine similarity service
  end

  def tfidf_as_array
    tfidf_vector.tr('[]', '').split(', ').map!(&:to_f) unless tfidf_vector.nil?
  end

  private

  def stemmify_query
    update(stem: query.split(' ').map(&:stem).join(' '))
  end
end
