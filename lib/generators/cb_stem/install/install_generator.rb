require 'rails/generators/active_record'
require 'cb_stem/generators/helper'

module CbStem

  module Generators

    # Install Gem
    class InstallGenerator < ActiveRecord::Generators::Base

      include CbStem::Generators::Helper

      desc 'Installs CbStem and generates the necessary migrations & overwrites'
      source_root File.expand_path('../templates', __FILE__)

      argument :name, type: :string, default: 'AdminUser'
      class_option :skip_active_admin, type: :string, default: false, alias: :aa

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
        return if options[:skip_active_admin]
        invoke 'active_admin:install', [name]
      end

      def install_configs
        invoke 'cb_stem:assets'
        invoke 'cb_stem:initializers', [name]
        invoke 'cb_stem:admin:admin_user', [name]
      end

    end

  end

end
