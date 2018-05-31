module CbStem

  class FileItem < MediaItem

    include CbStem::FileTypeIdentifier

    mount_uploader :file, ::CbStem::MediaUploader

    validates :file, presence: true

    before_validation :set_filename

    private

    def set_filename
      self.name ||= file.filename
    end

  end

end
