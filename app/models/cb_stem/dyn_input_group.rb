module CbStem

  class DynInputGroup < ApplicationRecord

    acts_as_list scope: :cb_stem_dyn_input_config_id

    belongs_to :dyn_input_config,
               class_name: 'CbStem::DynInputConfig',
               foreign_key: 'cb_stem_dyn_input_config_id',
               inverse_of: :dyn_input_groups
    has_many :dyn_inputs,
             class_name: 'CbStem::DynInput',
             foreign_key: 'cb_stem_dyn_input_group_id',
             inverse_of: :dyn_input_group,
             dependent: :destroy

    accepts_nested_attributes_for :dyn_inputs

    after_initialize :define_dyn_methods

    delegate :config, to: :dyn_input_config, allow_nil: true

    default_scope { order(position: :asc) }

    def self.permitted_params
      %i[id position _destroy] +
        [dyn_inputs_attributes: CbStem::DynInput.permitted_params]
    end

    # :reek:BooleanParameter
    def respond_to_missing?(method_name, include_private = false)
      dyn_attr?(method_name) || super
    end

    def method_missing(method_name, *args, &block)
      dyn_attr?(method_name) ? nil : super
    end

    private

    # :reek:ControlParameter :reek:ManualDispatch
    def dyn_attr?(method_name)
      method_name =~ /^dyn_/
    end

    def define_dyn_methods
      dyn_inputs.each do |x|
        self.class.send :define_method, "dyn_#{x.reference_key}" do
          get_value(x)
        end
        next unless x.type == CbStem::DynInputFile.to_s
        self.class.send :define_method, "dyn_#{x.reference_key}_url" do
          x.value_string_url
        end
      end
    end

    def get_value(input)
      case input.type
      when CbStem::DynInputText.to_s   then input.value_text
      when CbStem::DynInputNumber.to_s then input.value_number
      when CbStem::DynInputSelect.to_s, CbStem::DynInputRelation.to_s
        value = input.value_array
        input.field_config['multiple'] ? value : value.first
      else input.value_string
      end
    end

  end

end
