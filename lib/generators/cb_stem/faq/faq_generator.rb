require 'rails/generators/active_record'

module CbStem

  module Generators

    # Install Faq
    class FaqGenerator < ActiveRecord::Generators::Base

      desc 'Installs CbStem - Faq Module'
      argument :name, type: :string, default: 'Faq'

      source_root File.expand_path('../templates', __FILE__)

      def generate_admin
        template 'admin/faq.rb.erb', "app/admin/#{name.underscore}.rb"
        template 'admin/faq_category.rb.erb', "app/admin/#{name.underscore}_category.rb"
      end

      def generate_decorators
        template 'decorators/admin/faq_decorator.rb.erb',
                 "app/decorators/#{name.underscore}_decorator.rb"
      end

      def generate_models
        template 'models/faq.rb.erb', "app/models/#{name.underscore}.rb"
        template 'models/faq_category.rb.erb', "app/models/#{name.underscore}_category.rb"
      end

      def genrate_migrations
        migration_template 'migrate/create_faqs.rb.erb',
                           "db/migrate/create_#{name.underscore.pluralize}.rb"
        migration_template 'migrate/create_faq_categories.rb.erb',
                           "db/migrate/create_#{name.underscore}_categories.rb"
      end

    end

  end

end
