module ActiveAdmin

  module Views

    module Pages

      # Overwriting Views::Pages::Index - activeadmin/lib/active_admin/views/pages/index.rb
      class Index < Base

        WRAPPER_CLASS = 'container-fluid'.freeze

        def add_classes_to_body
          super
          @body.add_class('has-scopes') if any_table_tools?
        end

        def build_title_bar
          insert_tag(
            view_factory.title_bar,
            title,
            action_items_for_action,
            true
          )
        end

        def build_table_tools
          return unless any_table_tools?
          div class: 'table_tools' do
            build_scopes
            div class: 'index_ctrls' do
              build_batch_actions_selector
              build_index_list
            end
          end
        end

        def build_scopes
          return unless active_admin_config.scopes.any?
          scope_options = {
            scope_count: config.fetch(:scope_count, true)
          }

          div id: 'scopes' do
            scopes_renderer active_admin_config.scopes, scope_options
          end
        end

        private

        def build_page
          within @body do
            headers
            build_filters
            div(id: 'wrapper', class: WRAPPER_CLASS) do
              components.each do |x|
                send(x)
              end
            end
            footers
          end
        end

        def components
          %i[
            build_unsupported_browser build_title_bar
            build_page_content
          ]
        end

        def build_filters
          div id: 'filter-wrap' do
            div id: 'filters', class: 'collapse' do
              filter_sections.collect { |x| sidebar_section(x) }
            end
            div id: 'filter-backdrop',
                class: 'backdrop',
                'data-toggle': 'collapse',
                'data-target': '#filters'
          end
        end

        def filter_section?(section)
          section.name.to_sym == :filters
        end

        def filter_sections
          sections = []
          sidebar_sections_for_action.collect do |section|
            next unless filter_section?(section)
            sections.push section
          end
          sections
        end

        def build_batch_actions_selector
          return unless active_admin_config.batch_actions.any?
          insert_tag view_factory.batch_action_selector, active_admin_config.batch_actions
        end

        def build_sidebar(sections: [])
          sidebar_sections_for_action.collect do |section|
            next if filter_section?(section)
            sections.push section
          end
          return unless sections.any?
          div id: 'sidebar' do
            sections.collect do |section|
              sidebar_section(section)
            end
          end
        end

      end

    end

  end

end
