class TfIdfService
  def call(document, idf_vector = nil)
    @document = document
    @idf_vector = if idf_vector.nil?
                    Term.alphabetical.pluck(:idf)
                  else
                    idf_vector
                  end
    calculate_tfidf
  end

  private

  def calculate_tfidf
    document_vector = []
    document_stem = @document.stem.split(' ')
    Term.alphabetical.each do |t|
      document_vector << document_stem.count(t.stem)
    end
    stemcount_vector(document_vector)
    top_term = document_vector.max
    document_vector.map! { |element| element / top_term.to_f } unless top_term.zero?
    tfidf_vector = document_vector.zip(@idf_vector).map { |tf, idf| tf * idf }
    @document.update(tfidf_vector: tfidf_vector)
  end

  def stemcount_vector(stemcount)
    return if @document.is_a?(Search)
    @document.update(stemcount_vector: stemcount)
  end
end
