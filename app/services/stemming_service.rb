require 'stemmify'

class StemmingService
  def initialize(documents_file, terms_file)
    @documents_file = documents_file
    @terms_file = terms_file
  end

  def call
    cleanup_previous_documents_and_terms
    stemmify_documents
    stemmify_terms
    IdfService.new.call
  end

  private

  def cleanup_previous_documents_and_terms
    Document.destroy_all
    Term.destroy_all
  end

  def stemmify_documents
    @current_document = { title: '', body: '', stem: '' }
    File.readlines(@documents_file).each do |line|
      line = line.chomp
      if line.empty? # next document
        save_document
        next
      end
      prepared_line = stemmify_line(clear_line(line))
      if @current_document[:stem].empty?
        @current_document[:title] = line
        @current_document[:stem] += prepared_line + ' '
        next
      end
      @current_document[:body] += line + ' '
      @current_document[:stem] += prepared_line + ' '
    end
  end

  def save_document
    Document.create(title: fix_encoding(@current_document[:title]),
                    body: fix_encoding(@current_document[:body]).strip,
                    stem: @current_document[:stem].strip)
    @current_document = { title: '', body: '', stem: '' }
  end

  def fix_encoding(text)
    text.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
  end

  def clear_line(line)
    line = fix_encoding(line)
    line.downcase.gsub(/[^a-zA-Z0-9 ]/, '').split.join(' ')
  end

  def stemmify_line(line)
    line.split.map(&:stem).join(' ')
  end

  def stemmify_terms
    File.readlines(@terms_file).each do |line|
      original_term = line.chomp
      stemmed_term = original_term.stem
      Term.create(full: original_term, stem: stemmed_term)
    end
  end
end
