module ActiveAdmin

  module Views

    module Pages

      # Overwriting Header - activeadmin/lib/active_admin/views/pages/base.rb
      class Base < Arbre::HTML::Document

        WRAPPER_CLASS = 'container-fluid'.freeze

        def build(*args)
          super
          add_classes_to_body
          build_active_admin_head
          build_page
        end

        def build_page
          within @body do
            headers
            div id: 'wrapper', class: WRAPPER_CLASS do
              build_unsupported_browser
              build_title_bar
              build_page_content
            end
            footers
          end
        end

        def loading_backdrop
          div id: 'loading-backdrop' do
            div class: 'backdrop'
            div class: 'lds-ring'
          end
        end

        def headers
          build_header
          build_flash_messages
        end

        def footers
          loading_backdrop
        end

        def build_flash_messages
          div id: 'flash-wrapper' do
            notification_messages(flash_messages)
          end
        end

        def build_page_content
          div id: 'active_admin_content',
              class: (skip_sidebar? ? 'without_sidebar' : 'with_sidebar') do
            build_main_content_wrapper
            build_sidebar unless skip_sidebar?
          end
          build_html_contents unless skip_html_contents?
        end

        private

        def skip_sidebar?
          sidebar_sections_for_action.reject { |x| x.name == 'filters' }.empty? ||
            assigns[:skip_sidebar] == true
        end

        def build_main_content_wrapper
          div id: 'main_content_wrapper' do
            div id: 'main_content' do
              main_content
            end
            build_footer
          end
        end

        # Extra Section
        def html_contents_for_action
          if active_admin_config&.html_contents?
            active_admin_config.html_contents_for(params[:action], self)
          else
            []
          end
        end

        def build_html_contents
          div id: 'html_contents' do
            html_contents_for_action.collect do |section|
              html_content(section)
            end
          end
        end

        def skip_html_contents?
          html_contents_for_action.empty? || assigns[:skip_html_contents] == true
        end

      end

    end

  end

end
