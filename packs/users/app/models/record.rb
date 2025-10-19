# packs/users/app/models/record.rb
module Users
  class Record < ::ApplicationRecord
    self.abstract_class = true
    connects_to database: { writing: :primary, reading: :primary }
  end
end
