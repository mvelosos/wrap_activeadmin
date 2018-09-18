require 'rails/generators/active_record'

module WrapActiveadmin

  module Generators

    # Generates Tasks
    class TasksGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def setup_directory
        empty_directory 'db/wrap_activeadmin/seeds'
      end

      def generate_tasks
        template(
          'wrap_activeadmin/seed.rake.erb',
          'lib/tasks/wrap_activeadmin/seed.rake',
          force: true
        )
      end

    end

  end

end
