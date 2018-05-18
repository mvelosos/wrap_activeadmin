module ActiveAdmin

  module Views

    # Overwriting Panel - activeadmin/lib/active_admin/views/components/panel.rb
    class Panel < ActiveAdmin::Component

      def build(title = nil, attributes = {})
        super(attributes)
        add_class wrapper_class
        @title    = build_title(title)
        @contents = div(class: body_class)
      end

      def header_action(&block)
        @title << div(instance_exec(&block), class: 'header_action')
      end

      private

      def build_title(title)
        h5 title_tag(title), class: heading_class
      end

      def wrapper_class
        'card mb-3'
      end

      def heading_class
        'card-header'
      end

      def body_class
        'card-body'
      end

      def title_tag(title)
        return if title.blank?
        div title.to_s, class: 'title'
      end

    end

  end

end
