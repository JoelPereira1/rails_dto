# packs/roles/app/public/api.rb
module Roles
  module Public
    module Api
      def self.find_role_key_by_name(name) = Roles::RoleRepo.new.find_key_by_name(name)
      def self.exists?(role_key) = Roles::RoleRepo.new.exists?(role_key)
    end
  end
end
