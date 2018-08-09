require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end



use Rack::MethodOverride #allows for use of patch and delete methods
use GamesController 
use UsersController
run ApplicationController
