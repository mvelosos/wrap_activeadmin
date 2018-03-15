module ActiveAdmin

  module Views

    # Overwriting TabbedNavigation - activeadmin/lib/active_admin/views/tabbed_navigation.rb
    class TabbedNavigation < Component

      CURRENT_ITEM_CLASS = 'active'.freeze
      COLLAPSE_ANCHOR_OPTS = {
        class: 'with-sub-menu',
        'data-toggle': 'collapse'
      }.freeze

      attr_reader :menu

      def tag_name
        :div
      end

      def build(menu, options = {})
        @menu = menu
        super(default_options.merge(options))
        build_menu
      end

      private

      def build_menu
        menu_items.each do |item|
          build_menu_item(item)
        end
      end

      def build_menu_item(item, child = false)
        children = item.items(self).presence
        child ? build_child_menu(item, children) : build_parent_menu(item, children)
      end

      def build_link(item, children)
        children && dropdown_options(item)
        href = children ? "##{item.id}-sub-menu" : item.url(self)
        a item.html_options.merge(href: href) do
          if item.label(self).include? 'menu-text'
            text_node(item.label(self))
          else
            span(item.label(self), class: 'menu-text')
          end
          next unless children
        end
      end

      def build_children(children)
        children.each { |child| build_menu_item(child, true) }
      end

      def dropdown_options(item)
        item.html_options.reverse_merge!(COLLAPSE_ANCHOR_OPTS)
      end

      def add_current(li, item)
        return unless item.current?(assigns[:current_tab])
        li.add_class CURRENT_ITEM_CLASS
      end

      def build_child_menu(item, children)
        li id: item.id do |li|
          add_current(li, item)
          build_link(item, children)
        end
      end

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def build_parent_menu(item, children)
        status_klass = item.current?(assigns[:current_tab]) ? 'active' : nil
        ul class: 'list-group' do
          li id: item.id, class: "list-group-item #{status_klass}" do |li|
            add_current(li, item)
            build_link(item, children)
            next if children.blank?
            li.add_class 'has-sub-menu'
            menu_klass = %w[sub-menu list-unstyled collapse]
            menu_klass.push 'show' if item.current?(assigns[:current_tab])
            ul(
              id: "#{item.id}-sub-menu",
              class: menu_klass.join(' '),
              'data-parent': '#main-menu'
            ) do
              build_children(children)
            end
          end
        end
      end

    end

  end

end
