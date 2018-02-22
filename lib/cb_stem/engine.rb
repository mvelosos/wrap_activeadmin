require 'devise'
require 'bootstrap'
require 'active_admin'

module CbStem

  # Initialize Engine
  class Engine < ::Rails::Engine

    isolate_namespace CbStem

    ActiveAdmin.before_load do |app|
      require_relative 'extensions/batch_actions/views/batch_action_selector'
      app.view_factory.register batch_action_selector:
        ::ActiveAdmin::BatchActions::BatchActionSelector
    end

    initializer 'default configs' do |_app|
      ActiveAdmin.setup do |config|
        config.current_filters = false
      end
    end

    initializer 'assets precompile' do |_app|
      config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    end

    initializer 'view overrides' do |_app|
      require_helpers
      require_formtastic
      require_resources
      require_components
      require_inputs
      require_views
      require_pages
      require_others
    end

    initializer 'material_active_admin.assets.precompile' do |app|
      app.config.assets.precompile += %w[cb_stem/logo.png]
    end

    private

    def require_others
      require_each(
        %w[view_factory form_builder]
      )
    end

    def require_formtastic
      require_each(
        %w[
          base/wrapping base/html base/labelling actions/base
          inputs/boolean_input inputs/switch_input form_builder
        ],
        path: 'formtastic'
      )
    end

    def require_components
      require_each(
        %w[
          site_title table_for dropdown_menu panel attributes_table
          active_admin_form blank_slate columns scopes
        ],
        path: 'views/components'
      )
    end

    def require_resources
      require_each(
        %w[action_items],
        path: 'resource'
      )
    end

    def require_helpers
      require_each(
        %w[view_helpers],
        path: 'views/helpers'
      )
    end

    def require_views
      require_each(
        %w[
          action_items header tabbed_navigation
          title_bar index_as_table footer
        ],
        path: 'views'
      )
    end

    def require_pages
      require_each(
        %w[base index],
        path: 'views/pages'
      )
    end

    def require_inputs
      require_each(
        %w[base/search_method_select date_range_input forms],
        path: 'inputs/filters'
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
