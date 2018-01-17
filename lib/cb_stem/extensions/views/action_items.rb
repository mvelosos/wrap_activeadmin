module ActiveAdmin

  module Views

    # Overwriting ActionItems - activeadmin/lib/active_admin/views/action_items.rb
    class ActionItems < ActiveAdmin::Component

      WRAPPER_ID    = 'action_items'.freeze
      WRAPPER_CLASS = 'btn-group'.freeze
      ITEM_CLASS    = 'btn btn-secondary'.freeze

      def build(action_items)
        super(id: WRAPPER_ID, class: WRAPPER_CLASS)

        action_items.each do |action_item|
          text_node instance_exec(&action_item.block)
        end
      end

      private

      def action_btn(title, url, html_options = {})
        html_options[:class] = "#{ITEM_CLASS} #{html_options[:class]}"
        link_to title, url, html_options
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
