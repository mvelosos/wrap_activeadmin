require 'rails/generators/active_record'
require 'wrap_activeadmin/generators/helper'

module WrapActiveadmin

  module Generators

    # Generates Decorators
    class DecoratorsGenerator < Rails::Generators::Base

      include ::WrapActiveadmin::Generators::Helper

      source_root File.expand_path('../templates', __FILE__)

      def generate_decorators
        template(
          'application_decorator.rb.erb',
          'app/decorators/application_decorator.rb'
        )
      end

    end

  end

end
