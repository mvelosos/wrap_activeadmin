module CbStem

  class FolderItem < MediaItem

    after_touch :update_items_count

    private

    def update_items_count
      return unless children.count != items_count
      update(items_count: children.count)
    end

  end

end
