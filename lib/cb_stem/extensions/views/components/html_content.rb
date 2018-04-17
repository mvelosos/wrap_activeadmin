module ActiveAdmin

  module Views

    # Register HtmlContent in Views
    class HtmlContent < ActiveAdmin::Component

      builder_method :html_content

      def build(section)
        @section  = section
        @contents = div(class: 'html_contents')
        add_class(@section.custom_class) if @section.custom_class
        self.id = @section.id
        build_html_contents
      end

      # Renders attributes_table_for current resource
      def attributes_table(*args, &block)
        attributes_table_for resource, *args, &block
      end

      def add_child(child)
        @contents ? (@contents << child) : super
      end

      # Override children? to only report children when the panel's
      # contents have been added to. This ensures that the panel
      # correcly appends string values, etc.
      def children?
        @contents.children?
      end

      protected

      def build_html_contents
        if @section.block
          rvalue = instance_exec(&@section.block)
          self << rvalue if rvalue.is_a?(String)
        else
          render(@section.partial_name)
        end
      end

    end

  end

end
