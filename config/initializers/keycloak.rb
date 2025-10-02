require_relative "../../lib/keycloak/jwks_provider"

cfg = Rails.application.credentials.keycloak || {}
Rails.application.config.x.keycloak = {
  issuer:        cfg[:issuer],
  audience:      cfg[:audience],
  jwks_provider: Keycloak::JwksProvider.new(jwks_url: cfg[:jwks_url])
}
