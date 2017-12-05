class AddSearchReferenceToSearches < ActiveRecord::Migration[5.1]
  def change
    add_reference :searches, :search, foreign_key: true
  end
end
