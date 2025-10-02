class UserUpsertContract < Dry::Validation::Contract
  params do
    required(:external_id).filled(:string)
    required(:email).filled(:string)
    required(:name).filled(:string)
    optional(:locale).maybe(:string)
    required(:active).filled(:bool)
  end

  rule(:email) do
    key.failure("is not a valid email") unless URI::MailTo::EMAIL_REGEXP.match?(value.to_s)
  end

  rule(:locale) do
    next if value.nil?
    allowed = %w[pt en es]
    key.failure("must be one of #{allowed.join(', ')}") unless allowed.include?(value)
  end
end
