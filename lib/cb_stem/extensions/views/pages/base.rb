module ActiveAdmin

  module Views

    module Pages

      # Overwriting Header - activeadmin/lib/active_admin/views/pages/base.rb
      # rubocop:disable Metrics/ClassLength
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

        def headers
          build_header
          build_flash_messages
        end

        def footers
          # build_float_help
        end

        def build_float_help
          div id: 'float-help' do
            i class: 'nc-icon'
            span 'Need Help?'
          end
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

        def valid_links
          links.delete_if { |x| x =~ %r{<a\ href="\/admin">Admin<\/a>} }
        end

        def breadcrumbs?
          valid_links.present? && links.is_a?(::Array)
        end

        def build_breadcrumb(separator = '/')
          return unless breadcrumbs?
          ul id: 'breadcrumbs', class: 'list-inline my-3' do
            valid_links.each do |link|
              li class: 'list-inline-item mr-1 my-1' do
                text_node(link)
                span(separator, class: 'breadcrumb_sep ml-1 text-muted')
              end
            end
            li(text_node(title), class: 'list-inline-item mr-1')
          end
        end

        def links
          breadcrumb_config = active_admin_config && active_admin_config.breadcrumb
          if breadcrumb_config.is_a?(Proc)
            instance_exec(controller, &active_admin_config.breadcrumb)
          elsif breadcrumb_config.present?
            breadcrumb_links
          end
        end

        def build_main_content_wrapper
          div id: 'main_content_wrapper' do
            div id: 'main_content' do
              build_breadcrumb
              main_content
            end
            build_footer
          end
        end

        def flash_action
          div class: 'flash-action' do
            button(class: 'btn btn-link') { 'Dismiss' }
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
            notice: 'alert-success'
          }[type.to_sym] || type.to_s
        end

      end

    end

  end

end
