module WrapActiveadmin

  class DynInputGroup < ApplicationRecord

    acts_as_list scope: :wrap_activeadmin_dyn_input_config_id

    belongs_to :dyn_input_config,
               class_name: 'WrapActiveadmin::DynInputConfig',
               foreign_key: 'wrap_activeadmin_dyn_input_config_id',
               inverse_of: :dyn_input_groups,
               touch: true
    has_many :dyn_inputs,
             class_name: 'WrapActiveadmin::DynInput',
             foreign_key: 'wrap_activeadmin_dyn_input_group_id',
             inverse_of: :dyn_input_group,
             dependent: :destroy

    accepts_nested_attributes_for :dyn_inputs

    delegate :config, to: :dyn_input_config, allow_nil: true

    default_scope { order(position: :asc) }

    def self.permitted_params
      %i[id position _destroy] +
        [dyn_inputs_attributes: WrapActiveadmin::DynInput.permitted_params]
    end

    # :reek:BooleanParameter
    def respond_to_missing?(method_name, include_private = false)
      dyn_attr?(method_name) || super
    end

    def method_missing(method_name, *args, &block)
      dyn_attr?(method_name) ? find_input(method_name, *args) : super
    end

    private

    # :reek:ControlParameter :reek:ManualDispatch
    def dyn_attr?(method_name)
      method_name =~ /^dyn_/
    end

    def find_input(method_name, *args)
      key   = method_name.to_s.gsub(/(dyn_|_url)/, '')
      url   = method_name.to_s.include?('_url')
      input = dyn_inputs.find_by(reference_key: key)
      get_value(input, url, *args)
    end

    def get_value(input, url, *args)
      return if input.blank?
      str = %w[value]
      str.push 'url' if url
      method_name = str.join('_')
      input.try(method_name, *args)
    end

  end

end
