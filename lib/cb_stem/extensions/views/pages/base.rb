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
          end
        end

        def headers
          build_header
          build_flash_messages
        end

        def build_flash_messages
          div id: 'flashes' do
            flash_messages.each do |type, message|
              div class: "alert #{bs_class_for(type)}" do
                flash_message(message)
                flash_action
              end
            end
          end
        end

        def build_page_content
          div id: 'active_admin_content',
              class: (skip_sidebar? ? 'without_sidebar' : 'with_sidebar') do
            build_main_content_wrapper
            build_sidebar unless skip_sidebar?
          end
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

        def flash_action
          div class: 'flash-action' do
            button(class: 'btn btn-link text-primary') { 'Dismiss' }
          end
        end

        def flash_message(message)
          div class: 'flash-message' do
            text_node safe_join([message])
          end
        end

        def bs_class_for(type)
          {
            success: 'alert-success',
            error: 'alert-danger',
            alert: 'alert-warning',
            notice: 'alert-info'
          }[type.to_sym] || type.to_s
        end

      end

    end

  end

end
