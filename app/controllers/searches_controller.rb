class SearchesController < ApplicationController
  def new
    @search = Search.new
    @collections = Collection.where(description: 'documents')
                             .or(Collection.where(description: 'terms'))
    return if results_param.empty?
    @found_documents = Document.most_relevant
    @previous_query = results_param[:query]
  end

  def create
    my_search = Search.create(search_params)
    my_search.find_results if my_search.query != Search.last(2).first.query
    redirect_to new_search_path(query: my_search.query)
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end

  def results_param
    params.permit(:query)
  end
end
