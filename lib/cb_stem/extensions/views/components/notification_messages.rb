module ActiveAdmin

  module Views

    # Custom Component - NotificationMessages
    class NotificationMessages < ActiveAdmin::Component

      builder_method :notification_messages

      def build(flashes)
        super(id: 'flashes')
        flashes.each do |type, message|
          div class: "alert #{bs_class_for(type)}" do
            flash_message(message)
            flash_action
          end
        end
      end

      private

      def flash_action
        div class: 'flash-action' do
          button(class: 'btn btn-link') { aa_icon('close') }
        end
      end

      def flash_message(message)
        div class: 'flash-message' do
          text_node safe_join([message])
        end
      end

      def bs_class_for(type)
        {
          success: 'alert-success',
          error: 'alert-danger',
          alert: 'alert-warning',
          notice: 'alert-primary'
        }[type.to_sym] || type.to_s
      end

    end

  end

end
