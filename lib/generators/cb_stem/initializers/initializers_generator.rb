require 'rails/generators/active_record'

module CbStem

  module Generators

    # Generates Initializers
    class InitializersGenerator < ActiveRecord::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      argument :name, type: :string, default: 'AdminUser'

      def overwrite_config
        @underscored_user_name = name.underscore.tr('/', '_')
        @use_authentication_method = name.present?
        template(
          'active_admin.rb.erb',
          'config/initializers/active_admin.rb',
          force: true
        )
      end

      def copy_view_helpers
        template(
          'view_helpers.rb.erb',
          'config/initializers/view_helpers.rb',
          force: true
        )
      end

    end

  end

end
