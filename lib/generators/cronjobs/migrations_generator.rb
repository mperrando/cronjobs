require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record/migration'

class Cronjobs::MigrationsGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  extend ActiveRecord::Generators::Migration
  source_root File.expand_path("../templates", __FILE__)
  def manifest
    migration_template 'create_cronjob_schedules.rb', 'db/migrate/create_cronjob_schedules.rb'
    migration_template 'create_cronjob_executions.rb', 'db/migrate/create_cronjob_executions.rb'
  end
end
