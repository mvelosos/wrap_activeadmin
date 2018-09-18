require 'rails/generators/active_record'
require 'wrap_activeadmin/generators/helper'

module WrapActiveadmin

  module Generators

    # Generates Uploaders
    class UploadersGenerator < Rails::Generators::Base

      include ::WrapActiveadmin::Generators::Helper

      source_root File.expand_path('../templates', __FILE__)

      def setup_directory
        empty_directory 'app/uploaders/wrap_activeadmin'
      end

      def generate_uploaders
        %w[application].each do |file|
          template(
            "#{file}_uploader.rb.erb",
            "app/uploaders/#{file}_uploader.rb"
          )
        end
      end

    end

  end

end
