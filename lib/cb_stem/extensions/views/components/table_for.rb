module ActiveAdmin

  module Views

    # Overwriting TableFor - activeadmin/lib/active_admin/views/components/table_for.rb
    class TableFor < Arbre::HTML::Table

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def build(obj, *attrs)
        options          = attrs.extract_options!
        options[:class] += 'table text-nowrap'
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
