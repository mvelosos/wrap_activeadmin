require 'devise'
require 'bootstrap-sass'
require 'active_admin'

module CbStem

  # Initialize Engine
  class Engine < ::Rails::Engine

    isolate_namespace CbStem

    initializer 'assets precompile' do |_app|
      config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    end

    initializer 'view overrides' do |_app|
      require_views
    end

    private

    def require_views
      require_each(
        %w[components/menu_item components/site_title tabbed_navigation header],
        'views/'
      )
    end

    def require_each(files, path)
      files.each do |x|
        require_relative "extensions/#{path}#{x}"
      end
    end

  end

end
