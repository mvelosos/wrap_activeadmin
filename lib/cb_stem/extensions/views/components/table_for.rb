module ActiveAdmin

  module Views

    # Overwriting TableFor - activeadmin/lib/active_admin/views/components/table_for.rb
    # rubocop:disable Metrics/ClassLength
    class TableFor < Arbre::HTML::Table

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def build(obj, *attrs)
        options          = attrs.extract_options!
        options[:class]  = [options[:class], 'table text-nowrap'].compact.join(' ')
        @sortable        = options.delete(:sortable)
        @collection      = obj.respond_to?(:each) && !obj.is_a?(Hash) ? obj : [obj]
        @resource_class  = options.delete(:i18n)
        @resource_class ||= @collection.klass if @collection.respond_to? :klass
        @columns         = []
        @row_class       = options.delete(:row_class)

        build_table
        super(options)
        columns(*attrs)
      end

      def resource_selection_toggle_cell
        label(class: 'input-checkbox') do
          input(
            type: 'checkbox',
            id: 'collection_selection_toggle_all',
            name: 'collection_selection_toggle_all',
            class: 'toggle_all'
          )
          span(class: 'checkbox-icon')
        end
      end

      def resource_selection_cell(resource)
        label(class: 'input-checkbox') do
          input(
            type: 'checkbox',
            id: "batch_action_item_#{resource.id}",
            value: resource.id,
            class: 'collection_selection',
            name: 'collection_selection[]'
          )
          span(class: 'checkbox-icon')
        end
      end

      ITEM_CLASS = 'btn btn-outline-primary btn-sm'.freeze

      def actions(options = {}, &block)
        defaults      = options.delete(:defaults) { true }
        name          = options.delete(:name)     { '' }
        dropdown      = options.delete(:dropdown) { true }
        dropdown_name = options.delete(:dropdown_name) { default_dropdown_name }
        options[:class] ||= 'col-actions'
        column name, options do |resource|
          render_action(resource, dropdown, dropdown_name, defaults, &block)
        end
      end

      private

      def default_dropdown_name
        I18n.t('active_admin.dropdown_actions.button_label', default: nil)
      end

      def render_action(resource, dropdown, dropdown_name, defaults, &block)
        if dropdown
          render_dropdown_actions(resource, dropdown_name, defaults, &block)
        else
          render_inline_actions(resource, defaults, &block)
        end
      end

      def render_dropdown_actions(resource, dropdown_name, defaults, &block)
        dropdown_menu dropdown_name, icon: 'menu-dots' do
          defaults(resource) if defaults
          instance_exec(resource, &block) if block_given?
        end
      end

      def render_inline_actions(resource, defaults, &block)
        table_actions do
          defaults(resource, css_class: ITEM_CLASS) if defaults
          if block_given?
            block_result = instance_exec(resource, &block)
            text_node block_result unless block_result.is_a? Arbre::Element
          end
        end
      end

      # rubocop:disable all
      def defaults(target, options = {})
        if target_controller(target).action_methods.include?('show') && authorized?(ActiveAdmin::Auth::READ, target)
          item I18n.t('active_admin.view'), find_routes(resource, target), class: "view_link #{options[:css_class]}", title: I18n.t('active_admin.view')
        end
        if target_controller(target).action_methods.include?('edit') && authorized?(ActiveAdmin::Auth::UPDATE, target)
          item I18n.t('active_admin.edit'), find_routes(resource, target, prefix: :edit), class: "edit_link #{options[:css_class]}", title: I18n.t('active_admin.edit')
        end
        if target_controller(target).action_methods.include?('destroy') && authorized?(ActiveAdmin::Auth::DESTROY, target)
          item I18n.t('active_admin.delete'), find_routes(resource, target), class: "delete_link #{options[:css_class]}", title: I18n.t('active_admin.delete'),
            method: :delete, data: { confirm:  I18n.t('active_admin.delete_title'), message: I18n.t('active_admin.delete_confirmation') }
        end
      end

      def find_routes(resource, target, prefix: nil)
        if is_belongs_to?(resource, target)
          [prefix, :admin, resource, target].reject(&:blank?)
        else
          [prefix, :admin, target].reject(&:blank?)
        end
      end

      def is_belongs_to?(resource, target)
        required_belongs_to?(target) && match_current_scope?(target, resource)
      end

      def required_belongs_to?(target)
        target = target.try(:decorated?) ? target.model : target
        config = active_admin_resource_for(target.class)
        config.belongs_to? && config.belongs_to_config.required?
      end

      def match_current_scope?(target, resource)
        config = active_admin_resource_for(target.class)
        config.belongs_to_config.target.resource_name.singular ==
          resource.model_name.singular
      end

      def target_controller_name(resource)
        [
          active_admin_namespace.module_name,
          resource.model_name.plural.camelize + 'Controller'
        ].compact.join('::')
      end

      # Returns the controller for this config
      def target_controller(resource)
        object = resource.decorated? ? resource.object : resource
        target_controller_name(object).constantize
      end

      # Register Table Actions
      class TableActions < ActiveAdmin::Component

        WRAPPER_CLASS = 'btn-group'.freeze

        builder_method :table_actions

        def build
          super(class: WRAPPER_CLASS)
        end

      end

      # Overwriting Table Column
      class Column

        def initialize(*args, &block)
          @options = args.extract_options!

          @title = args[0]
          html_classes = %w[table-col]
          if @options.key?(:class)
            html_classes << @options.delete(:class)
          elsif @title.present?
            html_classes << "col-#{ActiveAdmin::Dependency.rails.parameterize(@title.to_s)}"
          end
          @html_class = html_classes.join(' ')
          @data = args[1] || args[0]
          @data = block if block
          @resource_class = args[2]
        end

      end

    end

  end

end
