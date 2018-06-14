module CbStem

  # Application Uploader For Asset Uploads
  class ApplicationUploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def size_range
      0..10.megabytes
    end

  end

end
