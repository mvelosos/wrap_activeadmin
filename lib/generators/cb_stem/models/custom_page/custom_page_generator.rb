require 'rails/generators/active_record'

module CbStem

  module Generators

    # Install CustomPage
    class CustomPageGenerator < ActiveRecord::Generators::Base

      desc 'Installs CbStem - CustomPage Module'
      argument :name, type: :string, default: 'CustomPage'

      source_root File.expand_path('../templates', __FILE__)

      def generate_admin
        template 'admin/custom_page.rb.erb', "app/admin/#{name.underscore}.rb"
      end

      def generate_decorators
        template 'decorators/custom_page_decorator.rb.erb',
                 "app/decorators/#{name.underscore}_decorator.rb"
        template 'decorators/admin/custom_page_decorator.rb.erb',
                 "app/decorators/admin/#{name.underscore}_decorator.rb"
      end

      def generate_models
        template 'models/custom_page.rb.erb', "app/models/#{name.underscore}.rb"
      end

      def genrate_migrations
        migration_template 'migrate/create_custom_pages.rb.erb',
                           "db/migrate/create_#{name.underscore.pluralize}.rb"
      end

    end

  end

end
