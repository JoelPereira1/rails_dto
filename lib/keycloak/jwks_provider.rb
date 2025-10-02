# frozen_string_literal: true

require "net/http"
require "uri"
require "json"
require "openssl"
require "base64"

module Keycloak
class JwksProvider
  def initialize(jwks_url:, timeout: 3)
    @jwks_url = jwks_url
    @timeout  = timeout
  end

  def key_for(kid)
    jwks = fetch
    key_hash = jwks["keys"]&.find { _1["kid"] == kid }
    return unless key_hash

    e = Base64.urlsafe_decode64(key_hash["e"])
    n = Base64.urlsafe_decode64(key_hash["n"])

    pub = OpenSSL::PKey::RSA.new
    pub.set_key(OpenSSL::BN.new(n, 2), OpenSSL::BN.new(e, 2), nil)
    pub
  end

  private

  def fetch
    uri = URI.parse(@jwks_url)
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https",
                    open_timeout: @timeout, read_timeout: @timeout) do |http|
      res = http.get(uri.request_uri)
      JSON.parse(res.body)
    end
  end
end
end
