module ActiveAdmin

  module Views

    # Overwriting TableFor - activeadmin/lib/active_admin/views/components/table_for.rb
    class TableFor < Arbre::HTML::Table

      WRAPPER_CLASS = ' table'.freeze

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def build(obj, *attrs)
        options          = attrs.extract_options!
        options[:class] += WRAPPER_CLASS
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

    end

  end

end
