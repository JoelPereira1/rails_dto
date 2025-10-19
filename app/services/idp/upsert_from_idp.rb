require "dry/monads"
require "dry/monads/do"

class Idp::UpsertFromIdp
  include Dry::Monads[:result, :try]
  include Dry::Monads::Do.for(:call)

  def initialize(contract: UserUpsertContract.new)
    @contract = contract
  end

  def call(idp_payload)
    mapped = yield map_payload(idp_payload)
    dto  = yield build_dto(mapped)
    _ = yield validate(dto)
    user = yield upsert(dto)
    Success(user)
  end

  private

  def map_payload(payload)
    Try { KeycloakUserMapper.call(payload) }.to_result.or { |e| Failure[:mapping_error, error: e.message] }
  end

  def build_dto(hash)
    Try { ::UserUpsertDto.new(hash) }.to_result.or { |e| Failure[:dto_error, error: e.message] }
  end

  def validate(dto)
    v = @contract.call(
      external_id: dto.external_id,
      email: dto.normalized_email,
      name: dto.name,
      locale: dto.locale,
      active: dto.active
    )
    v.success? ? Success() : Failure[:validation_error, v.errors.to_h]
  end

  def upsert(dto)
    Try do
      ::Users::Public::Api.upsert_by_external_id(
        external_id: dto.external_id,
        email: dto.normalized_email,
        name: dto.name,
        locale: dto.locale,
        active: dto.active
      )
    end.to_result.or { |e| Failure[:persistence_error, error: e.message] }
  end
end
