module CbStem

  class MediaItem < ApplicationRecord

    has_ancestry touch: true,
                 orphan_strategy: :destroy
    acts_as_list scope: %i[ancestry]

    validates :title, presence: true

  end

end
