module ActiveAdmin

  class Resource

    # Overwriting ActionItems - activeadmin/lib/active_admin/resource/action_items.rb
    module ActionItems

      def action_items_for(action, render_context = nil)
        action_items.select { |item| item.display_on? action, render_context }.
          sort_by(&:priority).reverse
      end

      private

      # Adds the default action items to each resource
      def add_default_action_items
        add_default_new_action_item
        add_default_show_action_item
        add_default_edit_action_item
      end

      # Adds the default Destroy link on show
      def add_default_show_action_item
        add_action_item :destroy, only: :show do
          if destroy_action?
            action_btn(
              destroy_btn_title,
              resource_path(resource),
              icon: 'trash-round', method: :delete,
              data: { confirm: destroy_confirm }
            )
          end
        end
      end

      # Adds the default New link on index
      def add_default_new_action_item
        add_action_item :new, only: :index do
          if new_action?
            action_btn(
              new_btn_title,
              new_resource_path,
              icon: 'simple-add'
            )
          end
        end
      end

      # Adds the default Edit link on show
      def add_default_edit_action_item
        add_action_item :edit, only: :show do
          if edit_action?
            action_btn(
              edit_btn_title,
              edit_resource_path,
              icon: 'edit-74'
            )
          end
        end
      end

    end

  end

  # Overwrite ActionItem
  class ActionItem

    attr_accessor :block, :name, :options

    def priority
      options[:priority] || 999
    end

    def mobile
      options[:mobile].to_s.present? ? options[:mobile] : true
    end

  end

end
