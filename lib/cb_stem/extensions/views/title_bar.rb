module ActiveAdmin

  module Views

    # Overwriting TitleBar - activeadmin/lib/active_admin/views/title_bar.rb
    class TitleBar < Component

      def build(title, action_items, is_index_page = false)
        super(id: 'title_bar', class: 'navbar fixed-top navbar-expand-lg')
        @title         = title
        @action_items  = action_items
        @is_index_page = is_index_page
        build_titlebar
      end

      private

      def build_search_bar
        content_tag :input, class: 'form-control'
      end

      def build_sidebar_toggle
        div id: 'sidebar-toggle', class: 'btn btn-link ' do
          a 'data-toggle': 'collapse', 'data-target': '#header',
            title: I18n.t('active_admin.header_toggle') do
            div(class: 'tooltip-holder',
                'data-toggle': 'tooltip',
                'data-placement': 'bottom',
                'data-original-title': I18n.t('active_admin.header_toggle'))
            i '', class: 'nc-icon nc-menu-34'
          end
        end
      end

      def build_search_toggle
        title = I18n.t('active_admin.search_model', model: active_admin_config.resource_label).to_s
        div id: 'search-filter-toggle', class: 'btn btn-link ' do
          a title: title, 'data-toggle': 'collapse', 'data-target': '#filters' do
            div(class: 'tooltip-holder', 'data-toggle': 'tooltip',
                'data-placement': 'bottom',
                'data-original-title': title)
            i '', class: 'nc-icon nc-zoom-2'
          end
        end
      end

      # rubocop:disable Metrics/MethodLength
      def build_titlebar
        div id: 'titlebar-content', class: 'row d-flex justify-content-between' do
          div class: 'col-4 d-xl-none' do
            build_sidebar_toggle
          end
          div class: 'col-4 text-center text-xl-left site-title' do
            build_titlebar_left
          end
          div class: 'col-4' do
            build_titlebar_right
          end
        end
      end

      def build_titlebar_left
        div id: 'titlebar_left', class: 'navbar-brand mr-0 text-truncate' do
          text_node @title
        end
      end

      def build_titlebar_right
        div id: 'titlebar_right', class: 'text-right' do
          if @is_index_page
            build_search_bar
            build_search_toggle
          end
          build_action_items
        end
      end

      def build_action_items
        insert_tag(view_factory.action_items, @action_items)
      end

    end

  end

end
