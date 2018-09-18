module ActiveAdmin

  module Views

    # Overwriting ActionItems - activeadmin/lib/active_admin/views/action_items.rb
    class ActionItems < ActiveAdmin::Component

      WRAPPER_ID    = 'action_items'.freeze
      WRAPPER_CLASS = 'action-btns'.freeze

      def build(action_items)
        super(id: WRAPPER_ID, class: WRAPPER_CLASS)

        btn_items      = action_items.reject(&:dropdown)
        dropdown_items = action_items.select(&:dropdown)

        build_btns(btn_items)
        build_dropdown(dropdown_items)
      end

      private

      def build_btns(items)
        items.each do |action_item|
          mobile_klass = action_item.mobile ? nil : 'd-none d-sm-block'
          div class: "#{action_item.html_class} #{mobile_klass}" do
            instance_exec(&action_item.block)
          end
        end
      end

      def build_dropdown(items)
        return if items.blank?
        dropdown_menu '', icon: 'menu-dots' do
          items.each do |action_item|
            instance_exec(&action_item.block)
          end
        end
      end

      def destroy_action?
        controller.action_methods.include?('destroy') &&
          authorized?(ActiveAdmin::Auth::DESTROY, resource)
      end

      def destroy_confirm
        I18n.t('active_admin.delete_confirmation')
      end

      def destroy_title
        I18n.t('active_admin.delete_title')
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
