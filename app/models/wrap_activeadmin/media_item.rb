module WrapActiveadmin

  class MediaItem < ApplicationRecord

    include WrapActiveadmin::ReferenceKeyGenerator
    assign_reference_key :reference_key,
                         length: 4,
                         prefix: lambda { |x|
                           name = x.name[0..3]
                           "#{name&.gsub(/[^0-9A-Za-z]/, '')}_".downcase
                         }

    has_ancestry touch: true,
                 orphan_strategy: :destroy

    validates :name, presence: true

  end

end
