module CbStem

  class DynInputConfig < ApplicationRecord

    CONFIG_WHITELIST =
      %i[
        reference_key position type span
        label hint option required whitelist
      ].freeze

    acts_as_list scope: :dyn_inputable

    belongs_to :dyn_inputable, polymorphic: true
    has_many :dyn_input_groups,
             class_name: 'CbStem::DynInputGroup',
             foreign_key: 'cb_stem_dyn_input_config_id',
             inverse_of: :dyn_input_config,
             dependent: :destroy
    has_many :dyn_inputs, through: :dyn_input_groups

    accepts_nested_attributes_for :dyn_input_groups,
                                  reject_if: :all_blank, allow_destroy: true

    before_save :destroy_unrelated_children

    validates :reference_key, presence: true

    default_scope { order(position: :asc) }

    def self.permitted_params
      %i[id position name _destroy] +
        [dyn_input_groups_attributes: CbStem::DynInputGroup.permitted_params]
    end

    def config=(attrs)
      attrs = attrs.map { |x| x.slice(*CONFIG_WHITELIST) }
      attrs =
        attrs.select do |x|
          CbStem::DynInput::TYPES.include?("cb_stem/dyn_input_#{x['type']}".camelcase)
        end
      attrs.map { |x| x.reverse_merge! config_defaults }
      self[:config] = attrs
    end

    private

    def config_defaults
      @config_defaults ||=
        CONFIG_WHITELIST.each_with_object({}) do |i, hash|
          val =
            case i
            when 'required' then false
            end
          hash[i] = val
        end
    end

    def destroy_unrelated_children
      keys = config.map { |x| x['reference_key'] }
      dyn_inputs.where.not(reference_key: keys).destroy_all
    end

  end

end
