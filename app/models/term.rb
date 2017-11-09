class Term < ApplicationRecord
  scope :alphabetical, -> { all.order(stem: :asc) }
end
