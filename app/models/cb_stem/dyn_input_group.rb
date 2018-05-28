module CbStem

  class DynInputGroup < ApplicationRecord

    acts_as_list scope: :cb_stem_dyn_input_config_id

    belongs_to :dyn_input_config,
               class_name: 'CbStem::DynInputConfig'
    has_many :dyn_inputs,
             class_name: 'CbStem::DynInput',
             foreign_key: 'cb_stem_dyn_input_group_id',
             inverse_of: :dyn_input_group,
             dependent: :destroy

    accepts_nested_attributes_for :dyn_inputs

    delegate :config, to: :dyn_input_config, allow_nil: true

    default_scope { order(position: :asc) }

    def self.permitted_params
      %i[id position _destroy] +
        [dyn_inputs_attributes: CbStem::DynInput.permitted_params]
    end

  end

end
