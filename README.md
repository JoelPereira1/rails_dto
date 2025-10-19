# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  3.4.6

* System dependencies
  bundle install

* Configuration
  change database.yml if required

* Database creation
 rake db:create

* Database initialization
  rake db:migrate db:seed

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

for testing the dto usage via console we can mock a keycloak request like
payload = {"sub"=>"abc-123","email"=>"USER@EXAMPLE.com","name"=>"Jane Doe","locale"=>"pt","enabled"=>true}
and call the service
Idp::UpsertFromIdp.new.call(payload)



cat > db/roles_migrate/20251019120000_create_roles.rb <<'RUBY'
class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string :role_key, null: false
      t.string :name,     null: false
      t.timestamps
    end

    add_index :roles, :role_key, unique: true
  end
end
RUBY


bin/rails r 'Roles::Role.upsert_all([{role_key: "admin", name: "Admin"}, {role_key: "user", name: "User"}], unique_by: :role_key)'

UserRoleSync::AssignRole.new.call(external_id: "abc-123", role_name: "Admin")


bin/spring stop || true
bin/rails zeitwerk:check
bin/packwerk validate
bin/packwerk check
bin/packwerk validate

bundle exec rake graphwerk:update