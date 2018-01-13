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
      require_resources
      require_components
      require_views
      require_pages
      require_others
    end

    private

    def require_others
      require_each(
        %w[view_factory]
      )
    end

    def require_components
      require_each(
        %w[site_title table_for dropdown_menu],
        path: 'views/components'
      )
    end

    def require_resources
      require_each(
        %w[action_items],
        path: 'resource'
      )
    end

    def require_views
      require_each(
        %w[action_items header tabbed_navigation title_bar index_as_table],
        path: 'views'
      )
    end

    def require_pages
      require_each(
        %w[base],
        path: 'views/pages'
      )
    end

    def require_each(files, path: nil)
      file_path = ['extensions/', path].reject(&:blank?).join('/')
      files.each do |x|
        require_relative "#{file_path}/#{x}"
      end
    end

  end

end
