require "jwt"

module Keycloak
class KeycloakTokenVerifier
  class VerificationError < StandardError; end

  def initialize(issuer:, audience:, jwks_provider:)
    @issuer = issuer
    @aud    = audience
    @jwks   = jwks_provider
  end

  def verify!(auth_header)
    raise VerificationError, "missing Authorization header" if auth_header.to_s.strip.empty?

    token  = auth_header.split(" ").last
    header = JWT.decode(token, nil, false).last
    kid    = header["kid"] or raise VerificationError, "missing kid"
    key    = @jwks.key_for(kid) or raise VerificationError, "unknown kid"

    decoded, _ = JWT.decode(
      token,
      key,
      true,
      {
        algorithm: "RS256",
        iss: @issuer, verify_iss: true,
        aud: @aud,    verify_aud: true
      }
    )
    decoded # claims
  rescue JWT::DecodeError => e
    raise VerificationError, e.message
  end
end
end
