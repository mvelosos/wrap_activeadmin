module ActiveAdmin

  module Views

    # Overwriting TitleBar - activeadmin/lib/active_admin/views/title_bar.rb
    class TitleBar < Component

      def build(title, action_items, is_index_page = false)
        super(id: 'title_bar', class: 'navbar fixed-top bg-primary navbar-dark navbar-expand-lg')
        @title         = title
        @action_items  = action_items
        @is_index_page = is_index_page
        build_titlebar
      end

      private

      # def breadcrumbs?
      #   links[1..-1].present? && links.is_a?(::Array)
      # end

      def build_search_bar
        content_tag :input, class: 'form-control'
      end

      def build_sidebar_toggle
        div id: 'sidebar-toggle',
            class: 'btn btn-link ',
            'data-toggle': 'tooltip',
            'data-placement': 'bottom',
            'data-original-title': I18n.t('active_admin.header_toggle') do
          a 'data-toggle': 'collapse', 'data-target': '#header' do
            i '', class: 'nc-icon nc-menu-34'
          end
        end
      end

      def build_search_toggle
        title = I18n.t('active_admin.search_model', model: active_admin_config.resource_label).to_s
        div id: 'search-filter-toggle',
            class: 'btn btn-link ',
            'data-toggle': 'tooltip',
            'data-placement': 'bottom',
            'data-original-title': title do
          a 'data-toggle': 'collapse', 'data-target': '#filters' do
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
        div id: 'titlebar_left', class: 'navbar-brand mr-0' do
          text_node @title
          # if breadcrumbs?
          #   div class: 'dropdown' do
          #     a class: 'dropdown-toggle', 'data-toggle': 'dropdown' do
          #       span @title, class: 'text-truncate'
          #       i('', class: 'nc-icon nc-minimal-down')
          #     end
          #     build_breadcrumb
          #   end
          # else
          #   text_node @title
          # end
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

      # def build_breadcrumb
      #   return unless breadcrumbs?
      #   ul id: 'breadcrumbs', class: 'dropdown-menu' do
      #     links[1..-1].each { |link| li(text_node(link), class: 'dropdown-item') }
      #   end
      # end

      def build_action_items
        insert_tag(view_factory.action_items, @action_items)
      end

      # def links
      #   breadcrumb_config = active_admin_config && active_admin_config.breadcrumb
      #   if breadcrumb_config.is_a?(Proc)
      #     instance_exec(controller, &active_admin_config.breadcrumb)
      #   elsif breadcrumb_config.present?
      #     breadcrumb_links
      #   end
      # end

    end

  end

end
