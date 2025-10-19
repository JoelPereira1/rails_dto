# packs/users/app/repositories/user_repo.rb
module Users
  class UserRepo
    def upsert_by_external_id(attrs)
      u = Users::User.find_or_initialize_by(external_id: attrs.fetch(:external_id))
      u.assign_attributes(attrs.slice(:email, :name, :locale, :active, :role_key))
      u.save!
      u
    end

    def assign_role!(external_id:, role_key:)
      u = Users::User.find_by!(external_id: external_id)
      u.update!(role_key: role_key)
      u
    end
  end
end
