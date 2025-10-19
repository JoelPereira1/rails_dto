# packs/roles/app/models/role.rb
module Roles
  class Role < Record   # note: no need to write Roles::Record inside the Roles module
    validates :role_key, presence: true, uniqueness: true
    validates :name, presence: true
  end
end
