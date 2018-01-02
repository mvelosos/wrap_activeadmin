module ActiveAdmin

  module Views

    # Arbre component used to render ActiveAdmin::MenuItem
    class MenuItem < Component

      builder_method :menu_item
      attr_reader :label
      attr_reader :url
      attr_reader :priority

      # def build(item, options = {})
      #   super(options.merge(id: item.id))
      #   @label = helpers.render_in_context self, item.label
      #   @url = helpers.render_in_context self, item.url
      #   @priority = item.priority
      #   @submenu = nil
      #
      #   add_class 'current' if item.current? assigns[:current_tab]
      #
      #   if url
      #     a label, item.html_options.merge(href: url)
      #   else
      #     span label, item.html_options
      #   end
      #
      #   item.items.any? && add_class('dropdown')
      #   @submenu = menu(item)
      # end

    end

  end

end
