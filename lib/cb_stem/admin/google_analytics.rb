if CbStem.google_analytics.present?
  ActiveAdmin.register_page 'Google Analytics' do
    menu parent: 'analytics',
         priority: CbStem.google_analytics[:priority] || 10

    controller do
      include CbStem::DateRangeFilterFeatures

      before_action :init_google_service,
                    :init_date_range_filter

      private

      def init_google_service
        @google_service = CbStem::GoogleOauthService.call
      end
    end

    content do
      cb_stem_component('google_analytics/date_range_filter', url: %i[admin google_analytics])

      cb_stem_component(
        'google_analytics/page_view',
        property: google_service[:property],
        start_date: date_range_filter.from_date,
        end_date: date_range_filter.to_date
      )

      columns do
        column class: 'col-md-6' do
          cb_stem_component(
            'google_analytics/source',
            property: google_service[:property],
            start_date: date_range_filter.from_date,
            end_date: date_range_filter.to_date
          )
          cb_stem_component(
            'google_analytics/page_view_device',
            property: google_service[:property],
            start_date: date_range_filter.from_date,
            end_date: date_range_filter.to_date
          )
          cb_stem_component(
            'google_analytics/page_view_age',
            property: google_service[:property],
            start_date: date_range_filter.from_date,
            end_date: date_range_filter.to_date
          )
        end

        column class: 'col-md-6' do
          cb_stem_component(
            'google_analytics/session_bounce',
            property: google_service[:property],
            start_date: date_range_filter.from_date,
            end_date: date_range_filter.to_date
          )
          cb_stem_component(
            'google_analytics/session_duration',
            property: google_service[:property],
            start_date: date_range_filter.from_date,
            end_date: date_range_filter.to_date
          )
          cb_stem_component(
            'google_analytics/page_view_country',
            property: google_service[:property],
            start_date: date_range_filter.from_date,
            end_date: date_range_filter.to_date
          )
          cb_stem_component(
            'google_analytics/page_view_gender',
            property: google_service[:property],
            start_date: date_range_filter.from_date,
            end_date: date_range_filter.to_date
          )
        end
      end
    end
  end
end
