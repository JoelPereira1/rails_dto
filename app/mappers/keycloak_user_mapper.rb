class KeycloakUserMapper
  def self.call(payload)
    full_name =
      if payload["name"].to_s.strip != ""
        payload["name"]
      else
        [ payload["given_name"], payload["family_name"] ].compact.join(" ").strip
      end

    {
      external_id: payload["sub"] || payload["id"],
      email: payload["email"] || payload["preferred_username"],
      name: full_name.presence || (payload["preferred_username"] || "Unknown"),
      locale: payload["locale"],
      active: payload.key?("disabled") ? !payload["disabled"] : (payload["enabled"].nil? ? true : !!payload["enabled"])
    }
  end
end
