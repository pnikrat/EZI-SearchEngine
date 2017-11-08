class CollectionsController < ApplicationController
  before_action :files_present?, :correct_format?, only: :create

  def new
  end

  def create
    permitted = file_params
    documents_file = permitted[:document_file]
    terms_file = permitted[:term_file]
    Collection.create_or_update_file('documents', documents_file.original_filename)
    Collection.create_or_update_file('terms', terms_file.original_filename)
    StemmingService.new(documents_file.tempfile, terms_file.tempfile).call
    flash[:success] = 'Files correctly uploaded and indexed'
    redirect_to new_search_path
  end

  private

  def file_params
    params.permit(:document_file, :term_file)
  end

  def files_present?
    return unless params[:document_file].nil? || params[:term_file].nil?
    flash.now[:error] = 'One of files is missing'
    render 'new'
  end

  def correct_format?
    return if params[:document_file].original_filename.end_with?('.txt') &&
              params[:term_file].original_filename.end_with?('.txt')
    flash.now[:error] = 'One of files is of incorrect format. Use .txt format.'
    render 'new'
  end
end
