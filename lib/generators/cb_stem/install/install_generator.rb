require 'rails/generators/active_record'

module CbStem

  # Install Gem
  class InstallGenerator < Rails::Generators::Base

    desc 'Installs CbStem and generates the necessary migrations & overwrites'
    source_root File.expand_path('../templates', __FILE__)

    def copy_samples
      template 'sample.rb.erb', 'dev/sample.rb'
    end

  end

end
