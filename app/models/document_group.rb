class DocumentGroup < ApplicationRecord
  has_many :documents, dependent: :nullify
  scope :ordered, -> { order(id: :asc).all }

  def self.most_documents_first
    left_joins(:documents).group(:id).order('COUNT(documents.id) DESC')
  end
end
