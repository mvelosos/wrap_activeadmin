module CbStem

  class DateRangeFilter

    FILTER_TYPES = %w[today this_week this_month this_year custom].freeze
    DATE_FORMAT  = '%m/%d/%Y'.freeze

    include CbStem::NonDbModel

    attr_accessor :filter_type, :from, :to

    validates :filter_type,
              presence: true
    validates :from, :to,
              presence: true,
              if: proc { |x| x.filter_type == 'custom' }

    def self.filter_types
      FILTER_TYPES.map do |x|
        [human_filter_type(x), x]
      end
    end

    def self.human_filter_type(filter_type)
      I18n.t("cb_stem.activerecord.attributes.date_range_filter.filter_types/#{filter_type}")
    end

    def filter_type
      @filter_type ||= FILTER_TYPES[0]
    end

    def filter_type_human
      self.class.human_filter_type(filter_type)
    end

    def from
      @from ||= (Time.zone.today - 7.days).strftime(DATE_FORMAT)
    end

    def to
      @to ||= Time.zone.today.strftime(DATE_FORMAT)
    end

    def from_date
      @from_date ||= Date.strptime(from, DATE_FORMAT)
    end

    def to_date
      @to_date ||= Date.strptime(to, DATE_FORMAT)
    end

  end

end
