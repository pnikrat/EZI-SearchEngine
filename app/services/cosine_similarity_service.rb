class CosineSimilarityService
  def initialize(search, offset = 0, update_db = true)
    @search = search
    @offset = offset
    @update_db = update_db
  end

  def call
    calculate_cosine_similarity
  end

  private

  def calculate_cosine_similarity
    document_group = determine_group
    document_group ||= Document.alphabetical
    document_group.each do |d|
      numerator = VectorOperations.scalar_product(d.tfidf_vector, @search.tfidf_vector)
      denominator = VectorOperations.magnitude(d.tfidf_vector) * VectorOperations.magnitude(@search.tfidf_vector)
      if denominator.zero?
        perform_update(d, 0.0)
      else
        perform_update(d, (numerator / denominator).round(5))
      end
    end
    document_group.pluck(:cosine_similarity) unless @update_db
  end

  def determine_group
    return nil if @offset.zero?
    Document.alphabetical(@offset)
  end

  def perform_update(d, value)
    if @update_db
      d.update_columns(cosine_similarity: value)
    else
      d.cosine_similarity = value
    end
  end
end
