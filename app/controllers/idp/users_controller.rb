class Idp::UsersController < ApplicationController
  def create
    cfg = Rails.configuration.x.keycloak
    verifier = KeycloakTokenVerifier.new(
      issuer: cfg[:issuer],
      audience: cfg[:audience],
      jwks_provider: cfg[:jwks_provider]
    )

    claims = verifier.verify!(request.headers["Authorization"])

    # If your JWT doesn’t include all profile fields,
    # fetch more from Keycloak Admin API here using claims["sub"].

    result = Users::UpsertFromIdP.new.call(claims)

    case result
    in Dry::Monads::Success(user)
      render json: {
        id: user.id, external_id: user.external_id, email: user.email,
        name: user.name, locale: user.locale, active: user.active
      }, status: :ok
    in Dry::Monads::Failure([ :validation_error, errs ])
      render json: { errors: errs }, status: :unprocessable_entity
    in Dry::Monads::Failure([ reason, meta ])
      render json: { error: reason, meta: meta }, status: :bad_request
    end
  rescue KeycloakTokenVerifier::VerificationError => e
    render json: { error: "unauthorized", detail: e.message }, status: :unauthorized
  end
end
