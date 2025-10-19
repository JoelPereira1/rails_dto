# packs/user_role_sync/app/services/user_role_dto.rb
require "dry-struct"

module UserRoleSync
  class UserRoleDto < Dry::Struct
    attribute :external_id, Types::String
    attribute :role_name,   Types::String
    def normalized_role_name = role_name.strip
  end
end
