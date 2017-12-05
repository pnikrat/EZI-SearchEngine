require 'matrix'

class CMatrixService
  def initialize(search)
    @search = search
  end

  def call
    calculate_cmatrix
    maximize_coexistence
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
  end

  def maximize_coexistence
    query_terms = @search.stem.split(' ')
    position_in_cmatrix = []
    query_terms.each do |t|
      position_in_cmatrix << Term.alphabetical.pluck(:stem).index(t)
    end
    position_in_cmatrix = position_in_cmatrix.compact # remove nils
    return if position_in_cmatrix.empty?
    term_columns = position_in_cmatrix.map { |pos| @cmatrix.column_vectors[pos] }
    total = term_columns.sum
    hashed_totals = Hash[(0...total.size).zip(total)]
    position_in_cmatrix.each { |banned| hashed_totals.delete(banned) }
    proposals = hashed_totals.sort_by { |k, v| -v }.first(5).map(&:first)
    proposals.map { |prop| Term.alphabetical.pluck(:full)[prop] }
  end

  def normalize_by_magnitude(v)
    magnitude = VectorOperations.magnitude(v)
    return v.map(&:to_f) if magnitude.zero?
    v.map { |element| element.to_f / magnitude.to_f }
  end
end
