class TfIdfService
  def call
    calculate_idf
    binding.pry
  end

  private

  def calculate_idf
    documents = Document.count.to_f
    Term.all.each do |t|
      documents_with_term = count_documents_with_term(t.stem)
      t.update(idf: Math.log10(documents / documents_with_term))
    end
  end

  def count_documents_with_term(term_stem)
    count = 0
    Document.all.each do |d|
      count += 1 if d.stem.include?(term_stem)
    end
    count.to_f
  end
end
