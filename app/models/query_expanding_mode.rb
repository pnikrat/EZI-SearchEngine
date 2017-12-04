class QueryExpandingMode < ApplicationRecord
  def self.active?
    QueryExpandingMode.first.active
  end

  def self.toggle
    QueryExpandingMode.first.toggle(:active).save
  end
end
