module ActiveAdmin

  module Views

    class TabbedNavigation < Component

      attr_reader :menu

      def build(menu, options = {})
        @menu = menu
        super(default_options.merge(options))
        build_menu
      end

      private

      # def build_menu_item(item)
      #   li id: item.id do |li|
      #     li.add_class 'current' if item.current? assigns[:current_tab]
      #     build_item(item)
      #     # build_link(item, children)
      #     # build_nested_menu(li, children)
      #   end
      # end
      #
      # def build_item(item)
      #   children = item.items(self).presence
      #   if url = item.url(self)
      #     build_link(item, children)
      #   else
      #     span item.label(self), item.html_options
      #   end
      #   return if children.blank?
      #   puts 'children'
      # end
      #
      # # def build_nested_menu(li, children)
      # #   return if children.blank?
      # #   li.add_class 'dropdown'
      # #   ul class: 'dropdown-menu' do
      # #     children.each { |child| build_menu_item child }
      # #   end
      # # end
      #
      # def build_link(item, _children)
      #   opts = item.html_options.merge(class: 'dropdown-toggle', data: { toggle: 'dropdown' })
      #   link_to safe_join[item.label(self), caret], item.url(self), opts
      # end
      # #
      # # def dropdown_toggle(item)
      # #   opts = item.html_options.merge(class: 'dropdown-toggle', data: { toggle: 'dropdown' })
      # #   text_node link_to item.label(self), item.url(self), opts
      # # end
      # #
      # # def menu_link(item)
      # #   text_node link_to item.label(self), item.url(self), item.html_options
      # # end
      # #
      # # def link_item(item, children)
      # #   children.present? ? dropdown_toggle(item) : menu_link(item)
      # # end
      # #
      # # def text_item(item)
      # #   text_node span(item.label(self), item.html_options)
      # # end
      #
      # def caret
      #   span class: 'caret'
      # end

    end

  end

end
