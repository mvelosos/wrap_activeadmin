module ActiveAdmin

  module Views

    # Overwriting TitleBar - activeadmin/lib/active_admin/views/title_bar.rb
    class TitleBar < Component

      def build(title, action_items)
        super(id: 'title_bar')
        @title = title
        @action_items = action_items
        build_titlebar_left
        build_titlebar_right
      end

      private

      def build_titlebar_left
        div id: 'titlebar_left' do
          build_breadcrumb
        end
      end

      def build_titlebar_right
        div id: 'titlebar_right' do
          build_action_items
        end
      end

      def build_breadcrumb
        return unless links.present? && links.is_a?(::Array)
        ul class: 'breadcrumb' do
          links.each { |link| li(text_node(link)) }
          li @title, class: 'active'
        end
      end

      def build_action_items
        insert_tag(view_factory.action_items, @action_items)
      end

      def links
        breadcrumb_config = active_admin_config && active_admin_config.breadcrumb
        if breadcrumb_config.is_a?(Proc)
          instance_exec(controller, &active_admin_config.breadcrumb)
        elsif breadcrumb_config.present?
          breadcrumb_links
        end
      end

    end

  end

end
