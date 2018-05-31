module ActiveAdmin

  module Views

    # Overwriting DropdownMenu - activeadmin/lib/active_admin/views/components/dropdown_menu.rb
    class DropdownMenu < ActiveAdmin::Component

      WRAPPER_CLASS = 'dropdown'.freeze
      TOGGLE_CLASS  = 'btn dropdown-toggle'.freeze
      MENU_CLASS    = 'dropdown-menu'.freeze
      ITEM_CLASS    = 'dropdown-item'.freeze

      def build(name, options = {})
        options = options.dup

        # Easily set options for the button or menu
        button_options = options.delete(:button) || {}
        menu_options   = options.delete(:menu) || {}
        @icon   = options.delete(:icon) || 'minimal-down'
        @button = build_button(name, button_options)
        @menu   = build_menu(menu_options)
        klass   = [WRAPPER_CLASS, options[:class]].reject(&:blank?).join(' ')
        super(options.merge(class: klass))
      end

      def item(*args)
        within @menu do
          li build_link(*args)
        end
      end

      def item_divider
        within @menu do
          li class: 'dropdown-divider'
        end
      end

      def raw_item(item)
        within @menu do
          li item
        end
      end

      private

      def build_link(*args)
        options = args.extract_options!
        klass   = options[:class].to_s.split(' ')
        klass.push(ITEM_CLASS).join(' ')
        options[:class] = klass
        link_to(*args, options)
      end

      def build_button(name, button_options)
        button_options[:class] ||= 'btn-link'
        button_options[:class] << " #{TOGGLE_CLASS}"
        button_options['data-toggle'] = 'dropdown'

        button_options[:href] = '#'

        a button_options do
          text_node(name)
          i('', class: "nc-icon nc-#{@icon}")
        end
      end

      def build_menu(options)
        options[:class] ||= ''
        options[:class] << " #{MENU_CLASS}"
        ul(options)
      end

    end

  end

end
