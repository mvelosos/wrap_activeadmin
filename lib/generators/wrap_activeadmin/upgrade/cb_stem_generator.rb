require 'rails/generators/active_record'

module WrapActiveadmin

  module Generators

    module Upgrade

      # Generates CbStem Upgrades
      class CbStemGenerator < Rails::Generators::Base

        include Rails::Generators::Migration

        desc 'Upgrades CbStem to WrapActiveadmin'
        source_root File.expand_path('../templates', __FILE__)

        def self.next_migration_number(dirname)
          next_migration_number = current_migration_number(dirname) + 1
          ActiveRecord::Migration.next_migration_number(next_migration_number)
        end

        def generate_migrations
          migration_template(
            'migrate/upgrade_to_wrap_activeadmin.rb.erb',
            "db/migrate/upgrade_to_wrap_activeadmin.rb"
          )
        end

      end

    end

  end

end
