# packs/user_role_sync/app/services/assign_role.rb
require "dry/monads"; require "dry/monads/do"
module UserRoleSync
  class AssignRole
    include Dry::Monads[:result, :try]
    include Dry::Monads::Do.for(:call)

    def initialize(contract: UserRoleContract.new)
      @contract = contract
    end

    def call(params)
      _   = yield validate(params)
      key = yield resolve_role_key(params[:role_name])
      _   = yield assign_role(params[:external_id], key)
      Success(:ok)
    end

    private

    def validate(params)
      v = @contract.call(params)
      v.success? ? Success() : Failure[:validation_error, v.errors.to_h]
    end

    def resolve_role_key(role_name)
      key = Roles::Api.find_role_key_by_name(role_name.to_s.strip)
      key ? Success(key) : Failure[:not_found, { role_name: role_name }]
    end

    def assign_role(external_id, role_key)
      Try { Users::Api.assign_role!(external_id:, role_key:) }
        .to_result.or { |e| Failure[:persistence_error, error: e.message] }
    end
  end
end
