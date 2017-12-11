class GroupingsController < ApplicationController
  def new
    @grouping = Grouping.new
  end

  def create
    my_grouping = Grouping.create(grouping_params)
    my_grouping.group
    redirect_to new_grouping_path
  end

  private

  def grouping_params
    params.require(:grouping).permit(
      :number_of_groups, :minimum_similarity, :similarity_stop_condition
    )
  end
end
