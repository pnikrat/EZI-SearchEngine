class SearchesController < ApplicationController
  def new
    @search = Search.new
    @collections = Collection.where(description: 'documents')
                             .or(Collection.where(description: 'terms'))
  end

  def create
    my_search = Search.create(search_params)
    my_search.find_results
    redirect_to new_search_path
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end
end
