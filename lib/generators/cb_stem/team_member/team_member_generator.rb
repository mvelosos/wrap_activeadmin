require 'rails/generators/active_record'

module CbStem

  module Generators

    # Install TeamMember
    class TeamMemberGenerator < ActiveRecord::Generators::Base

      desc 'Installs CbStem - TeamMember Module'
      argument :name, type: :string, default: 'TeamMember'

      source_root File.expand_path('../templates', __FILE__)

      def generate_admin
        template 'admin/team_member.rb.erb', "app/admin/#{name.underscore}.rb"
        template 'admin/team_member_category.rb.erb', "app/admin/#{name.underscore}_category.rb"
      end

      def generate_decorators
        template 'decorators/team_member_decorator.rb.erb',
                 "app/decorators/#{name.underscore}_decorator.rb"
        template 'decorators/admin/team_member_decorator.rb.erb',
                 "app/decorators/admin/#{name.underscore}_decorator.rb"
      end

      def generate_models
        template 'models/team_member.rb.erb', "app/models/#{name.underscore}.rb"
        template 'models/team_member_category.rb.erb', "app/models/#{name.underscore}_category.rb"
      end

      def genrate_migrations
        migration_template 'migrate/create_team_member_categories.rb.erb',
                           "db/migrate/create_#{name.underscore}_categories.rb"
        migration_template 'migrate/create_team_members.rb.erb',
                           "db/migrate/create_#{name.underscore.pluralize}.rb"
      end

    end

  end

end
