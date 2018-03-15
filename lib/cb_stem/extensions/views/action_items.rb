module ActiveAdmin

  module Views

    # Overwriting ActionItems - activeadmin/lib/active_admin/views/action_items.rb
    class ActionItems < ActiveAdmin::Component

      WRAPPER_ID    = 'action_items'.freeze
      WRAPPER_CLASS = 'action-btns'.freeze
      ITEM_CLASS    = 'btn btn-link'.freeze

      # rubocop:disable Metrics/MethodLength
      def build(action_items)
        super(id: WRAPPER_ID, class: WRAPPER_CLASS)

        items = action_items

        items.each do |action_item|
          mobile_klass = action_item.mobile ? nil : 'd-none d-sm-block'
          span class: "#{action_item.html_class} #{mobile_klass}" do
            instance_exec(&action_item.block)
          end
        end

        mobile_hidden_items = items.reject(&:mobile)

        return if mobile_hidden_items.empty?
        dropdown_menu '', icon: 'menu-dots', id: 'mobile-menu', class: 'd-block d-sm-none' do
          mobile_hidden_items.each do |action_item|
            raw_item instance_exec(&action_item.block)
          end
        end
      end

      private

      def action_btn(title, url, html_options = {})
        icon = html_options.delete(:icon) { nil }
        html_options[:class] = "#{ITEM_CLASS} #{html_options[:class]}".strip.squeeze
        options = html_options.merge(title: title, data: { toggle: 'tooltip', placement: 'bottom' })
        link_to url, options do
          concat content_tag(:i, '', class: "nc-icon nc-#{icon}") if icon
          concat content_tag(:span, title, class: 'action-text')
        end
      end

      def destroy_action?
        controller.action_methods.include?('destroy') &&
          authorized?(ActiveAdmin::Auth::DESTROY, resource)
      end

      def destroy_confirm
        I18n.t('active_admin.delete_confirmation')
      end

      def destroy_btn_title
        I18n.t('active_admin.delete_model', model: active_admin_config.resource_label).to_s
      end

      def new_action?
        controller.action_methods.include?('new') &&
          authorized?(ActiveAdmin::Auth::CREATE, active_admin_config.resource_class)
      end

      def edit_action?
        controller.action_methods.include?('edit') &&
          authorized?(ActiveAdmin::Auth::UPDATE, resource)
      end

      def new_btn_title
        I18n.t('active_admin.new_model', model: active_admin_config.resource_label).to_s
      end

      def edit_btn_title
        I18n.t('active_admin.edit_model', model: active_admin_config.resource_label).to_s
      end

    end

  end

end
