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

      def links
        breadcrumb_config = active_admin_config&.breadcrumb
        if breadcrumb_config.is_a?(Proc)
          instance_exec(controller, &active_admin_config.breadcrumb)
        elsif breadcrumb_config.present?
          breadcrumb_links
        end
      end

      def valid_links
        return if links.blank?
        links.delete_if { |x| x =~ %r{<a\ href="\/admin">Admin<\/a>} }
      end

      def build_breadcrumb(separator = '/')
        klass = 'list-inline-item mr-1 my-1'
        ul id: 'breadcrumbs', class: 'list-inline mb-0 text-truncate' do
          valid_links&.each do |link|
            li class: klass do
              text_node(link)
              span(separator, class: 'breadcrumb_sep ml-1 text-muted')
            end
          end
          li(text_node(@title), class: klass)
        end
      end

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
            i '', class: 'aa-icon aa-menu'
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
            i '', class: 'aa-icon aa-search'
          end
        end
      end

      # rubocop:disable Metrics/MethodLength
      def build_titlebar
        div id: 'titlebar-content', class: 'row d-flex justify-content-between align-items-center' do
          div class: 'col-4 d-xl-none' do
            build_sidebar_toggle
          end
          div class: 'col-4 col-xl-8 text-center text-xl-left' do
            build_titlebar_left
          end
          div class: 'col-4' do
            build_titlebar_right
          end
        end
      end
      # rubocop:enable Metrics/MethodLength

      def build_titlebar_left
        div id: 'titlebar_left', class: 'navbar-brand mr-0 text-truncate d-block' do
          build_breadcrumb
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
