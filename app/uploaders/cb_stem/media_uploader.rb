module CbStem

  # MediaUploader
  class MediaUploader < CbStem::ApplicationUploader

    IMAGE_TYPES = %w[jpg jpeg gif png].freeze
    FILE_TYPES  = %w[pdf doc docx json csv xlsx].freeze
    VIDEO_TYPES = %w[mov avi mkv mpeg mpeg2 mp4 3gp].freeze
    AUDIO_TYPES = %w[mp3 wma ra ram rm mid ogg].freeze

    include CbStem::ImageConcern
    include CbStem::FileConcern
    include CbStem::AudioConcern
    include CbStem::VideoConcern

    process :save_meta_to_model

    def extension_whitelist
      whitelist_method =
        [mounted_as, :extension_whitelist].join('_')
      model.try(whitelist_method) ||
        model.try(:extension_whitelist) ||
        default_whitelist
    end

    def default_whitelist
      IMAGE_TYPES + FILE_TYPES + VIDEO_TYPES + AUDIO_TYPES
    end

    def audio?(new_file = self)
      new_file.content_type&.start_with? 'audio'
    end

    def image?(new_file = self)
      new_file.content_type&.start_with? 'image'
    end

    def file?(new_file = self)
      new_file.content_type&.start_with? 'application'
    end

    def video?(new_file = self)
      new_file.content_type&.start_with? 'video'
    end

    def pdf?(new_file = self)
      new_file.content_type&.eql? 'application/pdf'
    end

    protected

    def save_meta_to_model
      model.try('file_type=', file.content_type) if file.content_type
      model.try('file_size=', file.size)
    end

  end

end
