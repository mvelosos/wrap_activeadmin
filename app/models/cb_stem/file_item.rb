module CbStem

  class FileItem < MediaItem

    mount_uploader :file, ::CbStem::MediaUploader

    validates :file, presence: true

    before_validation :set_filename

    def image?
      file_type&.start_with? 'image'
    end

    def video?
      file_type&.start_with? 'video'
    end

    def audio?
      file_type&.start_with? 'audio'
    end

    def file?
      !image? && !video? && !audio?
    end

    private

    def set_filename
      self.name ||= file.filename
    end

  end

end
