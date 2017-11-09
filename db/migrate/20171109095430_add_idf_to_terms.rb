class AddIdfToTerms < ActiveRecord::Migration[5.1]
  def change
    add_column :terms, :idf, :real
  end
end
