module CbStem

  class MediaItem < ApplicationRecord

    include CbStem::ReferenceKeyGenerator
    assign_reference_key :reference_key, length: 4, prefix: ->(x) { "#{x.name[0..3]}_" }

    has_ancestry touch: true,
                 orphan_strategy: :destroy

    validates :name, presence: true

  end

end
