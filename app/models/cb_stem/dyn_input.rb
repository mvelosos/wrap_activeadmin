module CbStem

  class DynInput < ApplicationRecord

    TYPES = %w[
      CbStem::DynInputText CbStem::DynInputString
      CbStem::DynInputNumber CbStem::DynInputFile
    ].freeze

    acts_as_list scope: :dyn_input_group

    belongs_to :dyn_input_group,
               class_name: 'CbStem::DynInputGroup'

    validates :reference_key, presence: true
    validates :type,          presence: true, inclusion: { in: TYPES }

    before_validation :mirror_configs

    delegate :config, to: :dyn_input_group, allow_nil: true

    default_scope { order(position: :asc) }

    def self.permitted_params
      %i[
        id label type position span reference_key required
        value_text value_string value_number input_config
        value_string_cache _destroy
      ]
    end

    def field_config
      return {} if config.blank?
      config.find { |x| x['reference_key'] == reference_key }
    end

    private

    def mirror_configs
      self.position = field_config['position']
      self.type     = "cb_stem/dyn_input_#{field_config['type']}".camelcase
    end

  end

end
