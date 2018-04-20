module CbStem

  class MediaItem < ApplicationRecord

    has_ancestry touch: true,
                 orphan_strategy: :destroy

    validates :name, presence: true

  end

end
