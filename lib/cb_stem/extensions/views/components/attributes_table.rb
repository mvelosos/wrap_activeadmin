module ActiveAdmin

  module Views

    # rubocop:disable Metrics/LineLength
    # Overwriting AttributesTable - activeadmin/lib/active_admin/views/components/attributes_table.rb
    class AttributesTable < ActiveAdmin::Component

      WRAPPER_CLASS = 'table-responsive'.freeze
      ITEM_CLASS    = 'table'.freeze

      def build(obj, *attrs)
        @collection     = Array.wrap(obj)
        @resource_class = @collection.first.class
        options = { class: WRAPPER_CLASS }
        options[:for] = @collection.first if single_record?
        super(options)
        @table = table(class: ITEM_CLASS)
        build_colgroups
        rows(*attrs)
      end

      def row(*args, &block)
        title   = args[0]
        options = args.extract_options!
        classes = []
        if options[:class]
          classes << options[:class]
        elsif title.present?
          classes << "row-#{ActiveAdmin::Dependency.rails.parameterize(title.to_s)}"
        end
        options[:class] = classes.join(' ')

        build_table(options, title, &block)
      end

      private

      def build_table(options, title, &block)
        @table << tr(options) do
          th do
            header_content_for(title)
          end
          @collection.each do |record|
            td do
              content_for(record, block || title)
            end
          end
        end
      end

    end

  end

end
