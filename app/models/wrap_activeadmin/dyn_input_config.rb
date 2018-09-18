module WrapActiveadmin

  class DynInputConfig < ApplicationRecord

    CONFIG_WHITELIST =
      %i[
        reference_key position type span config
        label hint option required whitelist richtext
        rows multiple relation_type relation_method collection
        option_template option_decorator
      ].freeze

    acts_as_list scope: :dyn_inputable

    belongs_to :dyn_inputable, polymorphic: true, touch: true
    has_many :dyn_input_groups,
             class_name: 'WrapActiveadmin::DynInputGroup',
             foreign_key: 'wrap_activeadmin_dyn_input_config_id',
             inverse_of: :dyn_input_config,
             dependent: :destroy
    has_many :dyn_inputs, through: :dyn_input_groups

    accepts_nested_attributes_for :dyn_input_groups,
                                  reject_if: :all_blank, allow_destroy: true

    before_validation :mirror_configs
    before_save :destroy_unrelated_children

    validates :reference_key, presence: true

    default_scope { order(position: :asc) }
    scope :not_with_keys, ->(keys) { where.not(reference_key: keys) }

    def self.permitted_params
      %i[id position name multiple sortable reference_key config _destroy] +
        [dyn_input_groups_attributes: WrapActiveadmin::DynInputGroup.permitted_params]
    end

    def config=(attrs)
      attrs = attrs.map { |x| x.slice(*CONFIG_WHITELIST) }
      attrs =
        attrs.select do |x|
          WrapActiveadmin::DynInput::TYPES.include?("wrap_activeadmin/dyn_input_#{x[:type]}".camelcase)
        end
      self[:config] = attrs.map { |x| x.reverse_merge! config_defaults }
    end

    private

    def mirror_configs
      defaults = dyn_inputable.try(:dyn_inputable_configs)
      return unless defaults
      config = defaults.find { |x| x[:reference_key] == reference_key }
      assign_attributes(config)
    end

    def config_defaults
      @config_defaults ||=
        CONFIG_WHITELIST.each_with_object({}) do |i, hash|
          hash[i] = default_attr(i)
        end
    end

    def destroy_unrelated_children
      keys = config.map { |x| x['reference_key'] }
      dyn_inputs.where.not(reference_key: keys).destroy_all
    end

    def default_attr(attr)
      case attr
      when :required, :richtext, :multiple,
           :hint, :label, :option_template, :option_decorator
        false
      when :relation_method then 'all'
      when :collection then []
      when :rows then 4
      when :span then 12
      end
    end

  end

end
