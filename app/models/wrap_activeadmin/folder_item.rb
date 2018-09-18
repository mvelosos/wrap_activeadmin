module WrapActiveadmin

  class FolderItem < MediaItem

    after_touch :update_info

    private

    def update_info
      update(
        items_count: children.count,
        file_size:   children.sum(:file_size)
      )
    end

  end

end
