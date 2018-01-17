module ActiveAdmin

  module Views

    # Overwriting Header - activeadmin/lib/active_admin/views/header.rb
    class Header < Component

      HEADER_ID      = 'header'.freeze
      WRAPPER_CLASS  = 'container-fluid'.freeze
      HEADER_CLASS   = 'navbar navbar-light navbar-expand-lg bg-light'.freeze
      MAIN_NAV_ID    = 'main-nav'.freeze
      MAIN_NAV_CLASS = 'navbar-nav mr-auto'.freeze
      ULT_NAV_ID     = 'utility-nav'.freeze
      ULT_NAV_CLASS  = 'navbar-nav'.freeze
      MENU_ID        = 'site-nav'.freeze
      MENU_CLASS     = 'collapse navbar-collapse'.freeze
      TOGGLE_CLASS   = 'navbar-toggler'.freeze
      ICON_CLASS     = 'navbar-toggler-icon'.freeze

      def tag_name
        :nav
      end

      def build(namespace, menu)
        super(id: HEADER_ID, class: HEADER_CLASS)

        @namespace = namespace
        @menu = menu
        @utility_menu = @namespace.fetch_menu(:utility_navigation)

        div class: WRAPPER_CLASS do
          build_title
          build_nav
        end
      end

      def build_title
        build_site_title
        build_nav_toggle
      end

      def build_nav_toggle
        button(
          class: TOGGLE_CLASS,
          'data-toggle': 'collapse',
          'data-target': "##{MENU_ID}"
        ) do
          span('', class: ICON_CLASS)
        end
      end

      def build_nav
        div id: MENU_ID, class: MENU_CLASS do
          build_global_navigation
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
          id: MAIN_NAV_ID,
          class: MAIN_NAV_CLASS
        )
      end

      def build_utility_navigation
        insert_tag(
          view_factory.utility_navigation,
          @utility_menu,
          id: ULT_NAV_ID,
          class: ULT_NAV_CLASS
        )
      end

    end

  end

end
