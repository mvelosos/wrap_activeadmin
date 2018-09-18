module WrapActiveadmin

  # Shared DateRangeFilterFeatures
  module DateRangeFilterFeatures

    extend ActiveSupport::Concern

    included do
      helper_method :init_date_range_filter
    end

    private

    def init_date_range_filter
      @date_range_filter =
        WrapActiveadmin::DateRangeFilter.new data_range_filter_params
    end

    def data_range_filter_params
      params.fetch(:date_range_filter, {}).permit(
        :from, :to
      )
    end

  end

end
