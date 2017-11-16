class CosineSimilarityService
  def initialize(search)
    @search = search
  end

  def call
    calculate_cosine_similarity
  end

  private

  def calculate_cosine_similarity
    ActiveRecord::Base.transaction do
      Document.select(:id, :tfidf_vector, :cosine_similarity).all.each do |d|
        numerator = scalar_product(d.tfidf_vector, @search.tfidf_vector)
        denominator = magnitude(d.tfidf_vector) * magnitude(@search.tfidf_vector)
        if denominator.zero?
          d.update_columns(cosine_similarity: 0.0)
        else
          d.update_columns(cosine_similarity: (numerator / denominator).round(5))
        end
      end
    end
  end

  def scalar_product(a, b)
    (0...a.count).inject(0) { |sum, i| sum + a[i] * b[i] }
  end

  def magnitude(a)
    Math.sqrt(a.map { |x| x**2 }.reduce(:+))
  end
end
