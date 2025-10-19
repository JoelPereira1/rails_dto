# packs/roles/app/repositories/role_repo.rb
module Roles
  class RoleRepo
    def find_key_by_name(name) = Roles::Role.find_by(name: name)&.role_key
    def exists?(key) = Roles::Role.exists?(role_key: key)
  end
end
