module WrapActiveadmin

  class FileItem < MediaItem

    include WrapActiveadmin::FileTypeIdentifier

    mount_uploader :file, ::WrapActiveadmin::MediaUploader

    validates :file, presence: true

    before_validation :set_filename

    private

    def set_filename
      self.name ||= file.filename
    end

  end

end
