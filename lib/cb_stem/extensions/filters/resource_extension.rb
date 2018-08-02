module ActiveAdmin

  module Filters

    # Overwriting ResourceExtension - activeadmin/lib/active_admin/filters/resource_extension.rb
    module ResourceExtension

      private

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def filters_sidebar_section
        ActiveAdmin::SidebarSection.new(
          :filters, only: :index, if: -> { active_admin_config.filters.any? }
        ) do
          header_action do
            div do
              a(class: 'btn btn-link text-secondary',
                title: I18n.t('active_admin.filter_close'),
                target: '_blank', 'data-toggle': 'collapse', 'data-target': '#filters') do
                div(class: 'tooltip-holder', 'data-toggle': 'tooltip',
                    'data-placement': 'bottom',
                    'data-original-title': I18n.t('active_admin.filter_close'))
                i('', class: 'aa-icon aa-close')
              end
            end
          end
          active_admin_filters_form_for assigns[:search], active_admin_config.filters
        end
      end
      # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

    end

  end

end
