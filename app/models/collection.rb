class Collection < ApplicationRecord
  def self.create_or_update_file(description, filename)
    existing_record = Collection.find_by(description: description)
    if existing_record.nil?
      Collection.create(description: description, filename: filename)
    else
      existing_record.update(filename: filename)
    end
  end
end
