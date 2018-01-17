module ActiveAdmin

  module Views

    # Overwriting TabbedNavigation - activeadmin/lib/active_admin/views/tabbed_navigation.rb
    class TabbedNavigation < Component

      CURRENT_ITEM_CLASS     = 'active'.freeze
      DROPDOWN_WRAPPER_CLASS = 'dropdown'.freeze
      DROPDOWN_MENU_CLASS    = 'dropdown-menu'.freeze
      DROPDOWN_ANCHOR_OPTS = {
        'data-toggle': 'dropdown'
      }.freeze

      attr_reader :menu

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

        li id: item.id do |li|
          add_current(li, item)
          build_link(item, children, child)
          li.add_class 'nav-item'
          next if children.blank?
          li.add_class DROPDOWN_WRAPPER_CLASS
          ul(class: DROPDOWN_MENU_CLASS) { build_children(children) }
        end
      end

      def build_link(item, children, child = false)
        children && dropdown_options(item)
        a item.html_options.merge(href: item.url(self)) do |a|
          a.add_class(child ? 'dropdown-item' : 'nav-link')
          text_node(item.label(self))
          next unless children
          a.add_class 'dropdown-toggle'
        end
      end

      def build_children(children)
        children.each { |child| build_menu_item(child, true) }
      end

      def dropdown_options(item)
        item.html_options.merge!(DROPDOWN_ANCHOR_OPTS)
      end

      def add_current(li, item)
        return unless item.current? assigns[:current_tab]
        li.add_class CURRENT_ITEM_CLASS
      end

    end

  end

end
