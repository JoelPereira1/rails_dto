class User < ApplicationRecord
  validates :external_id, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :locale, inclusion: { in: %w[pt en es], allow_nil: true }
end
