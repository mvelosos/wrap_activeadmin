module ActiveAdmin

  module Views

    # Overwriting Panel - activeadmin/lib/active_admin/views/components/panel.rb
    class Panel < ActiveAdmin::Component

      WRAPPER_CLASS = 'card mb-3'.freeze
      HEADING_CLASS = 'card-header'.freeze
      BODY_CLASS    = 'card-body'.freeze

      def build(title = nil, attributes = {})
        super(attributes)
        add_class WRAPPER_CLASS
        @title    = h5(title_tag(title), class: HEADING_CLASS) if title.present?
        @contents = div(class: BODY_CLASS)
      end

      def header_action(&block)
        @title << div(instance_exec(&block), class: 'header_action')
      end

      private

      def title_tag(title)
        div title.to_s, class: 'title'
      end

    end

  end

end
