module ActiveAdmin

  module Views

    # Overwriting Panel - activeadmin/lib/active_admin/views/components/panel.rb
    class Panel < ActiveAdmin::Component

      WRAPPER_CLASS = 'panel panel-default'.freeze
      HEADING_CLASS = 'panel-heading'.freeze
      BODY_CLASS    = 'panel-body'.freeze
      TITLE_CLASS   = 'panel-title'.freeze

      def build(title, attributes = {})
        super(attributes)
        add_class WRAPPER_CLASS
        @title =
          div class: HEADING_CLASS do
            h3(title.to_s, class: TITLE_CLASS)
          end
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
