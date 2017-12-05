class SearchesController < ApplicationController
  def new
    @search = Search.new
    @collections = Collection.where(description: 'documents')
                             .or(Collection.where(description: 'terms'))
    @expanding_mode = QueryExpandingMode.active?
    return if results_param.empty?
    @found_documents = Document.most_relevant
    @previous_search = Search.find(results_param[:query])
    @previous_search_query = @previous_search.query
  end

  def create
    my_search = Search.create(search_params)
    if my_search.query != Search.last(2).first.query || Document.last.cosine_similarity.nil? || QueryExpandingMode.active?
      my_search.find_results
    end
    redirect_to new_search_path(query: my_search.id)
  end

  def togglemode
    QueryExpandingMode.toggle
    redirect_to new_search_path
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end

  def results_param
    params.permit(:query)
  end
end
