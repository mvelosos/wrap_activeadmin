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
        @title    = h5(title.to_s, class: HEADING_CLASS) if title.present?
        @contents = div(class: BODY_CLASS)
      end

      def header_action(*args)
        action = args[0]

        @title << div(class: 'header_action') do
          action
        end
      end

    end

  end

end
