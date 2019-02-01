module WrapActiveadmin

  # AudioUploader
  module AudioConcern

    extend ActiveSupport::Concern

    included do
      version :mp3 do
        include CarrierWave::Audio
        process convert: [{ output_format: :mp3 }], if: :should_process_audio?

        def full_filename(for_file)
          "#{super.chomp(File.extname(super))}.mp3"
        end
      end
    end

    def should_process_audio?(*args)
      audio?(*args) && process_upload?(*args)
    end

  end

end
