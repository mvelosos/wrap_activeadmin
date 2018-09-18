module ActiveAdmin

  module Views

    # Overwriting Header - activeadmin/lib/active_admin/views/header.rb
    class Header < Component

      def tag_name
        :div
      end

      def build(namespace, menu)
        super(id: 'header-wrap')
        @namespace    = namespace
        @menu         = menu
        @utility_menu = @namespace.fetch_menu(:utility_navigation)
        nav id: 'header' do
          build_title
          build_nav
        end
        div id: 'header-backdrop', class: 'backdrop',
            'data-toggle': 'collapse', 'data-target': '#header'
      end

      def build_title
        build_site_title
      end

      def build_nav
        div id: 'main-menu' do
          build_global_navigation
          hr
          build_utility_navigation
        end
      end

      def build_site_title
        insert_tag(
          view_factory.site_title,
          @namespace
        )
      end

      def build_global_navigation
        insert_tag(
          view_factory.global_navigation,
          @menu,
          id: 'main-nav'
        )
      end

      def build_utility_navigation
        insert_tag(
          view_factory.utility_navigation,
          @utility_menu,
          id: 'utility-nav'
        )
      end

    end

  end

end
