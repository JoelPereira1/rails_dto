# packs/users/app/models/user.rb
module Users
  class User < Record
    validates :name, :email, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    # validates :role_key, presence: true # user must have a role
    validates :external_id, presence: true, uniqueness: true
    validates :locale, inclusion: { in: %w[pt en es], allow_nil: true }
  end
end
