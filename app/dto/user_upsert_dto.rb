require "dry-struct"
require_relative "types"

class UserUpsertDto < Dry::Struct
  attribute :external_id, Types::String
  attribute :email,       Types::String
  attribute :name,        Types::String
  attribute :locale,      Types::String.optional
  attribute :active,      Types::Bool

  def normalized_email = email.strip.downcase
end
