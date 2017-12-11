class Grouping < ApplicationRecord
  def group
    GroupingService.new(self).call
  end
end
