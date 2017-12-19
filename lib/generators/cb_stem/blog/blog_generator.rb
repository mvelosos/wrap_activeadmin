require 'rails/generators/active_record'

module CbStem

  module Generators

    # Install Blog
    class BlogGenerator < ActiveRecord::Generators::Base

      desc 'Installs CbStem - Blog Module'
      argument :name, type: :string, default: 'Blog'

      source_root File.expand_path('../templates', __FILE__)

      def copy_sample
        template 'sample.rb.erb', "dev/#{name.underscore}/sample.rb"
      end

    end

  end

end
