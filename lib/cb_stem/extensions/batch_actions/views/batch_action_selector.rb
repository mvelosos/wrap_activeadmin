module ActiveAdmin

  module BatchActions

    # Overwriting Footer - activeadmin/lib/active_admin/batch_actions/views/batch_action_selector.rb
    class BatchActionSelector < ActiveAdmin::Component

      private

      # rubocop:disable Metrics/MethodLength, Metrics/LineLength, Metrics/AbcSize
      def build_drop_down
        return if batch_actions_to_display.empty?
        dropdown_menu I18n.t('active_admin.batch_actions.button_label'),
                      class: 'batch_actions_selector dropdown_menu',
                      button: { class: 'disabled btn-light' } do
          batch_actions_to_display.each do |batch_action|
            confirmation_text = render_or_call_method_or_proc_on(self, batch_action.confirm)
            message           = render_or_call_method_or_proc_on(self, batch_action.message)
            batch_form        = render_or_call_method_or_proc_on(self, batch_action.batch_form)
            inputs            = batch_form.present? ? nil : render_in_context(self, batch_action.inputs).to_json

            options = {
              :class         => 'batch_action',
              'data-action'  => batch_action.sym,
              'data-confirm' => confirmation_text,
              'data-inputs'  => inputs
            }

            default_title = render_or_call_method_or_proc_on(self, batch_action.title)
            title = I18n.t("active_admin.batch_actions.labels.#{batch_action.sym}", default: default_title)
            label = I18n.t('active_admin.batch_actions.action_label', title: title)

            item label, '#', options.reverse_merge!('data-message': message, 'data-form': batch_form)
          end
        end
      end

    end

  end

end
