require 'rails/generators/active_record'
require 'wrap_activeadmin/generators/helper'

module WrapActiveadmin

  module Generators

    # Install Gem
    class InstallGenerator < ActiveRecord::Generators::Base

      include ::WrapActiveadmin::Generators::Helper

      desc 'Installs WrapActiveadmin and generates the necessary migrations & overwrites'
      source_root File.expand_path('../templates', __FILE__)

      argument :name, type: :string, default: 'AdminUser'
      class_option :skip_activeadmin, type: :string, default: true, alias: :aa

      def revert_devise
        case behavior
        when :revoke
          %w[
            config/initializers/devise.rb
            config/locales/devise.en.yml
          ].each do |file|
            remove_file(file)
          end
        end
      end

      def install_active_admin
        return if options[:skip_activeadmin]
        invoke 'active_admin:install', [name]
      end

      def install_configs
        invoke 'wrap_activeadmin:assets'
        invoke 'wrap_activeadmin:initializers'
        invoke 'wrap_activeadmin:models:admin_user'
        invoke 'wrap_activeadmin:uploaders'
        invoke 'wrap_activeadmin:tasks'
      end

      def install_decorators
        invoke 'wrap_activeadmin:decorators'
      end

      def remove_unused_files
        %w[
          app/admin/dashboard.rb
        ].each do |file|
          remove_file file
        end
      end

    end

  end

end
