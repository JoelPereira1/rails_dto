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
Users::UpsertFromIdp.new.call(payload)