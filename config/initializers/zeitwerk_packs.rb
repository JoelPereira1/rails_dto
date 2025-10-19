# config/initializers/zeitwerk_packs.rb

Users        = Module.new unless defined?(Users)
Roles        = Module.new unless defined?(Roles)
UserRoleSync = Module.new unless defined?(UserRoleSync)

# shared = top-level constants (no '/app', no namespace)
Rails.autoloaders.main.push_dir Rails.root.join("packs/shared")

# namespaced packs; root is ".../app"
Rails.autoloaders.main.push_dir Rails.root.join("packs/users", "app"),          namespace: Users
Rails.autoloaders.main.push_dir Rails.root.join("packs/roles", "app"),          namespace: Roles
Rails.autoloaders.main.push_dir Rails.root.join("packs/user_role_sync", "app"), namespace: UserRoleSync

# keep folders tidy but constants short
Rails.autoloaders.main.collapse Rails.root.join("packs/users", "app", "models")
Rails.autoloaders.main.collapse Rails.root.join("packs/users", "app", "repositories")
Rails.autoloaders.main.collapse Rails.root.join("packs/users", "app", "services")
# Rails.autoloaders.main.collapse Rails.root.join("packs/users", "app", "public")

Rails.autoloaders.main.collapse Rails.root.join("packs/roles", "app", "models")
Rails.autoloaders.main.collapse Rails.root.join("packs/roles", "app", "repositories")
Rails.autoloaders.main.collapse Rails.root.join("packs/roles", "app", "services")
# Rails.autoloaders.main.collapse Rails.root.join("packs/roles", "app", "public")

Rails.autoloaders.main.collapse Rails.root.join("packs/user_role_sync", "app", "services")
