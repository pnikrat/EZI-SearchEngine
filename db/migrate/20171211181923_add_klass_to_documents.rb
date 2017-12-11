class AddKlassToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :klass, :string
  end
end
