# packs/roles/app/models/record.rb
module Roles
  class Record < ::ApplicationRecord
    self.abstract_class = true
    connects_to database: { writing: :roles, reading: :roles }
  end
end
