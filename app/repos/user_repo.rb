class UserRepo
  def find_by_external_id(external_id)
    User.find_by(external_id: external_id)
  end

  def upsert_by_external_id(attrs)
    user = find_by_external_id(attrs[:external_id]) || User.new(external_id: attrs[:external_id])
    user.assign_attributes(
      email: attrs[:email].downcase,
      name: attrs[:name],
      locale: attrs[:locale],
      active: attrs[:active]
    )
    user.save!
    user
  end
end
