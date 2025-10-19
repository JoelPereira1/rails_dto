# packs/user_role_sync/app/services/user_role_contract.rb
module UserRoleSync
  class UserRoleContract < Dry::Validation::Contract
    params do
      required(:external_id).filled(:string)
      required(:role_name).filled(:string)
    end
  end
end
