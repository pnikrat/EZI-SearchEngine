require 'stemmify'

class Search < ApplicationRecord
  def find_results
    prepared_query = stemmify_query
    binding.pry
  end

  private

  def stemmify_query
    query.split.map(&:stem)
  end
end
