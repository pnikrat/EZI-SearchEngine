require 'matrix'

class CMatrixService
  def initialize(search)
    @search = search
  end

  def call
    calculate_cmatrix

  end

  private

  def calculate_cmatrix
    array_of_columns = []
    Document.alphabetical.each do |d|
      array_of_columns << d.stemcount_vector
    end
    term_document_matrix = Matrix.columns(array_of_columns)
    normalized_rows = term_document_matrix.row_vectors.map { |row| normalize_by_magnitude(row) }
    norm_term_document_matrix = Matrix.rows(normalized_rows)
    @cmatrix = (norm_term_document_matrix * norm_term_document_matrix.t).round(6)
    # to find term index based on stem
    # Term.alphabetical.pluck(:stem).index('classif')
  end

  def normalize_by_magnitude(v)
    magnitude = VectorOperations.magnitude(v)
    return v.map(&:to_f) if magnitude.zero?
    v.map { |element| element.to_f / magnitude.to_f }
  end
end
