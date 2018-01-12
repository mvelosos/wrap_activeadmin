require 'rails/generators/active_record'

module CbStem

  module Generators

    # Install Blog
    class BlogGenerator < ActiveRecord::Generators::Base

      desc 'Installs CbStem - Blog Module'
      argument :name, type: :string, default: 'Blog'

      source_root File.expand_path('../templates', __FILE__)

      def generate_admin
        template 'admin/blog.rb.erb', "app/admin/#{name.underscore}.rb"
        template 'admin/blog_category.rb.erb', "app/admin/#{name.underscore}_category.rb"
      end

      def generate_models
        template 'models/blog.rb.erb', "app/models/#{name.underscore}.rb"
        template 'models/blog_category.rb.erb', "app/models/#{name.underscore}_category.rb"
      end

      def generate_decorators
        template 'decorators/blog_decorator.rb.erb',
                 "app/decorators/#{name.underscore}_decorator.rb"
        template 'decorators/admin/blog_decorator.rb.erb',
                 "app/decorators/admin/#{name.underscore}_decorator.rb"
      end

      def generate_migrations
        migration_template 'migrate/create_blogs.rb.erb',
                           "db/migrate/create_#{name.underscore.pluralize}.rb"
        migration_template 'migrate/create_blog_categories.rb.erb',
                           "db/migrate/create_#{name.underscore}_categories.rb"
      end

    end

  end

end
