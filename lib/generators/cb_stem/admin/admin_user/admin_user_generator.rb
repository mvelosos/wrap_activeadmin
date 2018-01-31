require 'rails/generators/active_record'

module CbStem

  module Generators

    module Admin

      # Generates Initializers
      class AdminUserGenerator < ActiveRecord::Generators::Base

        source_root File.expand_path('../templates', __FILE__)

        argument :name, type: :string, default: 'AdminUser'

        def admin
          template(
            'admin_user.rb.erb',
            "app/admin/#{name.underscore}.rb",
            force: true
          )
        end

      end

    end

  end

end
