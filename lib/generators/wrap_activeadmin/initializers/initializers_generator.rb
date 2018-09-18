require 'rails/generators/active_record'

module WrapActiveadmin

  module Generators

    # Generates Initializers
    class InitializersGenerator < ActiveRecord::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      argument :name, type: :string, default: 'AdminUser'

      def setup_directory
        empty_directory 'config/initializers/wrap_activeadmin'
      end

      def generate_configs
        template(
          'wrap_activeadmin/menu.rb.erb',
          'config/initializers/wrap_activeadmin/menu.rb'
        )
        template(
          'wrap_activeadmin/menu.rb.erb',
          'config/initializers/wrap_activeadmin/config.rb'
        )
      end

      def generate_kaminari_patch
        template(
          'wrap_activeadmin/kaminari.rb.erb',
          'config/initializers/wrap_activeadmin/kaminari.rb'
        )
      end

      def generate_fog
        template(
          'fog.rb.erb',
          'config/initializers/fog.rb'
        )
      end

    end

  end

end
