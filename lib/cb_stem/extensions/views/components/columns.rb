module ActiveAdmin

  module Views

    # Overwriting Columns - activeadmin/lib/active_admin/views/components/columns.rb
    class Columns < ActiveAdmin::Component

      def default_class_name
        'row'
      end

      # Override add child to set widths
      def add_child(*)
        super
        calculate_columns!
      end

      protected

      # Calculate our columns sizes and margins
      def calculate_columns!
        columns.each(&:assign_column_span)
      end

    end

    # Overwriting Columns
    class Column < ActiveAdmin::Component

      COL_CLASS = 'col-md'.freeze

      def build(options = {})
        options = options.dup
        @klass     = options.delete(:class)
        @span_size = options.delete(:span)
        super(options)
      end

      def assign_column_span
        set_attribute :class, "#{column_klass} #{@klass}".strip
      end

      def column_klass
        @span_size ? "#{COL_CLASS}-#{@span_size}" : COL_CLASS
      end

    end

  end

end
