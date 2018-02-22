module ActiveAdmin

  module Views

    module Pages

      # Overwriting Header - activeadmin/lib/active_admin/views/pages/base.rb
      class Base < Arbre::HTML::Document

        WRAPPER_CLASS = 'container py-3'.freeze

        def build(*args)
          super
          add_classes_to_body
          build_active_admin_head
          build_page
        end

        def build_page
          within @body do
            build_header
            div id: 'wrapper', class: WRAPPER_CLASS do
              build_unsupported_browser
              build_title_bar
              build_page_content
              build_footer
            end
          end
        end

        def build_flash_messages
          div class: 'flashes' do
            flash_messages.each do |type, message|
              div message, class: "alert #{bs_class_for(type)}"
            end
          end
        end

        private

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
