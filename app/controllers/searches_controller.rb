class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def create
    my_search = Search.create(search_params)
    redirect_to new_search_path
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end
end
