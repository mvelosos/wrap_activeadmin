module ActiveAdmin

  module Views

    # Overwriting IndexAsTable - activeadmin/lib/active_admin/views/index_as_table.rb
    class IndexAsTable < ActiveAdmin::Component

      WRAPPER_CLASS = 'table-responsive'.freeze
      TABLE_CLASS   = 'index_table index'.freeze

      # rubocop:disable Metrics/MethodLength
      def build(page_presenter, collection)
        super(class: 'table-responsive')
        table_options = {
          id: "index_table_#{active_admin_config.resource_name.plural}",
          sortable: true,
          class: TABLE_CLASS,
          i18n: active_admin_config.resource_class,
          paginator: page_presenter[:paginator] != false,
          row_class: page_presenter[:row_class]
        }

        table_for collection, table_options do |t|
          table_config_block = page_presenter.block || default_table
          instance_exec(t, &table_config_block)
        end
      end

      # Register IndexTableFor
      class IndexTableFor < ::ActiveAdmin::Views::TableFor

        ITEM_CLASS = 'btn btn-outline-primary btn-sm'.freeze

        def actions(options = {}, &block)
          defaults      = options.delete(:defaults) { true }
          name          = options.delete(:name)     { '' }
          dropdown      = options.delete(:dropdown) { false }
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

        # Register Table Actions
        class TableActions < ActiveAdmin::Component

          WRAPPER_CLASS = 'btn-group'.freeze

          builder_method :table_actions

          def build
            super(class: WRAPPER_CLASS)
          end

        end

      end

    end

  end

end
