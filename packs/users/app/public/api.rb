# packs/users/app/public/api.rb
module Users
  module Public
    module Api
      def self.upsert_by_external_id(external_id:, email:, name:, locale:, active:)
        Users::UserRepo.new.upsert_by_external_id(
          external_id: external_id,
          email: email,
          name: name,
          locale: locale,
          active: active
        )
      end
    end
  end
end
