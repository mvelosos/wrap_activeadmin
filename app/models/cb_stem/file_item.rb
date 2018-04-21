module CbStem

  class FileItem < MediaItem

    mount_uploader :file, ::CbStem::MediaUploader

    validates :file, presence: true

    before_validation :set_filename

    def image?
      file_type&.start_with? 'image'
    end

    def file?
      !image?
    end

    private

    def set_filename
      self.name ||= file.filename
    end

  end

end
