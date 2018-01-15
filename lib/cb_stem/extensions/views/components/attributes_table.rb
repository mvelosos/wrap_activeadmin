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

    end

  end

end
