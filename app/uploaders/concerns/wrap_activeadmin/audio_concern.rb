module WrapActiveadmin

  # AudioUploader
  module AudioConcern

    extend ActiveSupport::Concern
    included do
      version :mp3, if: :audio? do
        include CarrierWave::Audio
        process convert: [{ output_format: :mp3 }], if: :process_upload?

        def full_filename(for_file)
          "#{super.chomp(File.extname(super))}.mp3"
        end
      end

    end

  end

end
