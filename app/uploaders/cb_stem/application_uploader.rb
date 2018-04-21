module CbStem

  # Application Uploader For Asset Uploads
  class ApplicationUploader < CarrierWave::Uploader::Base

    include CarrierWave::RMagick

    process :save_file_type_and_size

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def image?(new_file)
      new_file.content_type&.start_with? 'image'
    end

    def file?(new_file)
      new_file.content_type&.start_with? 'application'
    end

    def video?(new_file)
      new_file.content_type&.start_with? 'video'
    end

    def pdf?(new_file)
      new_file.content_type&.eql? 'application/pdf'
    end

    def save_file_type_and_size
      model.try('file_type=', file.content_type) if file.content_type
      model.try('file_size=', file.size)
    end

    def size_range
      0..10.megabytes
    end

  end

end
