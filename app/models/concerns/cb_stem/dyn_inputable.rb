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
        hit = (I18N_WHITELIST & attribute.to_s.split('.'))
        if hit.present?
          CbStem::DynInput.human_attribute_name(hit.first)
        else
          super
        end
      end

      def dyn_inputable_params
        [dyn_input_configs_attributes: CbStem::DynInputConfig.permitted_params]
      end

      def refresh_dyn_inputable_configs
        find_each.map do |x|
          x.update_dyn_input_configs
          x.update_dyn_inputs
        end
      end
    end

    def dyn_inputable_configs
      path = Rails.root.join('db', 'dyn_inputable', "#{self.class.to_s.underscore}.yml").to_s
      return unless File.exist?(path)
      key = inputable_config_mapping_key && try(inputable_config_mapping_key)
      load_dyn_input_config(key: key, path: path)
    end

    def dyn_collection(reference_key:)
      dyn_input_configs.
        find_by(reference_key: reference_key)&.dyn_input_groups
    end

    def dyn_resource(reference_key:)
      dyn_input_configs.
        find_by(reference_key: reference_key)&.dyn_input_groups&.first
    end

    def update_dyn_inputs
      dyn_input_configs.each do |x|
        inputs = x.config
        keys   = inputs.map { |d| d['reference_key'] }
        x.dyn_inputs.not_with_keys(keys)&.destroy_all
        x.dyn_inputs.find_each(&:save)
      end
    end

    def update_dyn_input_configs
      return unless try(:dyn_inputable_configs)
      keys = dyn_inputable_configs.map { |x| x[:reference_key] }
      dyn_input_configs.not_with_keys(keys)&.destroy_all
      dyn_inputable_configs.each do |x|
        dyn_input_configs.find_by(reference_key: x[:reference_key])&.update(x)
      end
    end

    private

    def inputable_config_mapping_key
      nil
    end

    def load_dyn_input_config(key:, path:)
      file = YAML.load_file(path)
      file.map(&:deep_symbolize_keys!)
      key.present? ? file.find { |x| x[:id] == key }&.fetch(:configs, {}) : file
    end

  end

end
