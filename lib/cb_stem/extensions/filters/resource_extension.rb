module ActiveAdmin

  module Filters

    # Overwriting ResourceExtension - activeadmin/lib/active_admin/filters/resource_extension.rb
    module ResourceExtension

      private

      # rubocop:disable Metric/MethodLength
      def filters_sidebar_section
        ActiveAdmin::SidebarSection.new(
          :filters, only: :index, if: -> { active_admin_config.filters.any? }
        ) do
          header_action do
            div title: I18n.t('active_admin.filter_close'),
                'data-toggle': 'tooltip', 'data-placement': 'bottom' do
              a(i('', class: 'nc-icon nc-simple-remove'),
                class: 'btn btn-link',
                target: '_blank', 'data-toggle': 'collapse', 'data-target': '#filters')
            end
          end
          active_admin_filters_form_for assigns[:search], active_admin_config.filters
        end
      end

    end

  end

end
