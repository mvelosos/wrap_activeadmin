module ActiveAdmin

  module Views

    # Overwriting DropdownMenu - activeadmin/lib/active_admin/views/components/dropdown_menu.rb
    class DropdownMenu < ActiveAdmin::Component

      def build(name, options = {})
        options = options.dup

        # Easily set options for the button or menu
        button_options = options.delete(:button) || {}
        menu_options = options.delete(:menu) || {}

        @button = build_button(name, button_options)
        @menu = build_menu(menu_options)

        super(options.merge(class: 'dropdown'))
      end

      private

      def build_button(name, button_options)
        button_options[:class] ||= ''
        button_options[:class] << ' btn btn-default btn-sm dropdown-toggle'
        button_options['data-toggle'] = 'dropdown'

        button_options[:href] = '#'

        a button_options do
          text_node(name)
          span('', class: 'caret')
        end
      end

      def build_menu(options)
        options[:class] ||= ''
        options[:class] << ' dropdown-menu'

        menu_list = ul(options)
        menu_list
      end

    end

  end

end
