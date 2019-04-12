module WrapActiveadmin

  # MediaUploader
  class MediaUploader < WrapActiveadmin::ApplicationUploader

    include WrapActiveadmin::ImageConcern
    include WrapActiveadmin::FileConcern
    include WrapActiveadmin::AudioConcern
    include WrapActiveadmin::VideoConcern

  end

end
