require 'matrix'

class GroupingService
  def initialize(grouping_order)
    @grouping_order = grouping_order
  end

  def call
    refresh_groups
    create_similarity_matrix
    perform_grouping
  end

  def refresh_groups
    DocumentGroup.destroy_all
    Document.alphabetical.each do |d|
      DocumentGroup.create(documents: [d])
    end
  end

  def create_similarity_matrix
    array_of_rows = []
    Document.alphabetical.each_with_index do |d, idx|
      raw_row = CosineSimilarityService.new(d, idx, false).call
      raw_row = Array.new(idx, 0.0) + raw_row
      (0...idx).each { |i| raw_row[i] = array_of_rows[i][idx] }
      array_of_rows << raw_row
    end
    @sim_matrix = Matrix.rows(array_of_rows)
  end

  def perform_grouping
    loop do
      find_max
      break if stop_condition_reached
      create_or_add_to_group
      perform_removal
      calculate_similarity_to_new_group
      @sim_matrix = @next_matrix
    end
  end

  def stop_condition_reached
    if @grouping_order.similarity_stop_condition
      @current_max[:value] <= @grouping_order.minimum_similarity
    else
      @sim_matrix.row_count <= @grouping_order.number_of_groups
    end
  end

  def find_max
    @current_max = { value: 0.0, x: nil, y: nil }
    sim_copy = Matrix.rows(@sim_matrix.row_vectors)
    sim_copy.row_vectors.each_with_index do |row, idx|
      row = row.to_a
      row[idx] = 0.0
      row_max, index = row.each_with_index.max
      next unless row_max > @current_max[:value]
      @current_max[:value] = row_max
      @current_max[:x] = idx
      @current_max[:y] = index
    end
  end

  def create_or_add_to_group
    groups = DocumentGroup.ordered.to_a
    first_merged_ids = groups[@current_max[:x]].documents.pluck(:id)
    second_merged_ids = groups[@current_max[:y]].documents.pluck(:id)
    merged_group_document_ids = first_merged_ids + second_merged_ids
    DocumentGroup.destroy(groups[@current_max[:x]].id)
    DocumentGroup.destroy(groups[@current_max[:y]].id)
    DocumentGroup.create(documents: Document.find(merged_group_document_ids))
  end

  def perform_removal
    new_columns = remove_vectors(@sim_matrix.column_vectors)
    new_rows = remove_vectors(Matrix.columns(new_columns).row_vectors)
    @next_matrix = Matrix.rows(new_rows)
  end

  def remove_vectors(vectors)
    vectors.reject.each_with_index { |_, idx| idx == @current_max[:x] || idx == @current_max[:y] }
  end

  def calculate_similarity_to_new_group
    similarity_row = []
    remove_vectors(@sim_matrix.row_vectors).each do |row|
      similarity = (row[@current_max[:x]] + row[@current_max[:y]]) / 2.0
      similarity_row << similarity
    end
    @next_matrix = Matrix.vstack(@next_matrix, Matrix.rows([similarity_row]))
    column = Matrix.rows([similarity_row + [1.0]]).t
    @next_matrix = Matrix.hstack(@next_matrix, column)
  end
end
