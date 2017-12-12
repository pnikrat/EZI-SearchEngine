class GroupingsController < ApplicationController
  def new
    @grouping = Grouping.new
    return if results_param.empty?
    @document_groups = DocumentGroup.most_documents_first
    last_grouping = Grouping.find(results_param[:grouping])
    @grouping_nog = last_grouping.number_of_groups
    @grouping_sim = last_grouping.minimum_similarity
    @grouping_sim_stop = last_grouping.similarity_stop_condition
  end

  def create
    my_grouping = Grouping.create(grouping_params)
    my_grouping.group
    redirect_to new_grouping_path(grouping: my_grouping.id)
  end

  private

  def grouping_params
    params.require(:grouping).permit(
      :number_of_groups, :minimum_similarity, :similarity_stop_condition
    )
  end

  def results_param
    params.permit(:grouping)
  end
end
