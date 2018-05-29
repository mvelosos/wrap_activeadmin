require 'rails/generators/active_record'

module CbStem

  module Generators

    module Models

      # Generates DynInputable
      class DynInputableGenerator < Rails::Generators::Base

        include Rails::Generators::Migration

        desc 'Installs CbStem - DynInputable Module'
        source_root File.expand_path('templates', __dir__)

        def self.next_migration_number(dirname)
          next_migration_number = current_migration_number(dirname) + 1
          ActiveRecord::Migration.next_migration_number(next_migration_number)
        end

        def generate_migrations
          %w[
            dyn_input_configs dyn_input_groups
            dyn_inputs
          ].each do |file|
            migration_template(
              "migrate/create_#{file}.rb.erb",
              "db/migrate/create_cb_stem_#{file}.rb"
            )
          end
        end

      end

    end

  end

end
