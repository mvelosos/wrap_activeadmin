module CbStem

  module DynInputable

    extend ActiveSupport::Concern

    I18N_WHITELIST = %w[value_string value_text value_number].freeze

    included do
      has_many :dyn_input_configs, as: :dyn_inputable,
                                   class_name: 'CbStem::DynInputConfig',
                                   inverse_of: :dyn_inputable,
                                   dependent: :destroy
      has_many :dyn_input_groups, through: :dyn_input_configs
      has_many :dyn_inputs,       through: :dyn_input_groups

      accepts_nested_attributes_for :dyn_input_configs,
                                    reject_if: :all_blank,
                                    allow_destroy: true
    end

    class_methods do
      def human_attribute_name(attribute, default: nil)
        hit = (I18N_WHITELIST & attribute.split('.'))
        if hit.present?
          CbStem::DynInput.human_attribute_name(hit.first)
        else
          super
        end
      end

      def dyn_inputable_params
        [dyn_input_configs_attributes: CbStem::DynInputConfig.permitted_params]
      end
    end

    def find_dyn_attr(config:, key:)
      config = dyn_input_configs.find_by(reference_key: config)
      config.dyn_inputs.where(reference_key: key)&.first
    end

  end

end
