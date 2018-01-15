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
        span_count = columns_span_count

        columns.each do |column|
          column.assign_column_span(span_count)
        end
      end

    end

    # Overwriting Columns
    class Column < ActiveAdmin::Component

      COLUMN_MAX = 12

      def build(options = {})
        options = options.dup
        @span_size = options.delete(:span) || 1
        super(options)
      end

      def assign_column_span(column_span)
        set_attribute :class, "col-md-#{COLUMN_MAX / column_span}"
      end

    end

  end

end
