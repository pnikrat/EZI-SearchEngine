class IdfService
  def call
    calculate_idf
    delegate_tfidf
  end

  private

  def calculate_idf
    documents = Document.count.to_f
    Term.all.each do |t|
      documents_with_term = count_documents_with_term(t.stem)
      idf = if documents_with_term.zero?
              0.0
            else
              Math.log10(documents / documents_with_term)
            end
      t.update(idf: idf)
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

def delegate_tfidf
  idf_vector = Term.alphabetical.pluck(:idf)
  Document.all.each do |d|
    TfIdfService.new.call(d, idf_vector)
  end
end
