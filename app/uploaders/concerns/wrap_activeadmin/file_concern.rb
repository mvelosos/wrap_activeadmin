module WrapActiveadmin

  # FileUploader
  module FileConcern

    extend ActiveSupport::Concern

    included do
      version :file_preview do
        process :cover,                     if: :should_process_pdf?
        process resize_to_fill: [800, 800], if: :should_process_pdf?
        process convert: :jpg,              if: :should_process_pdf?

        def full_filename(for_file = model.source.file)
          super.chomp(File.extname(super)) + '.jpg'
        end

        def cover
          manipulate! do |frame, index|
            frame if index.zero?
          end
        end
      end
    end

    def should_process_pdf?(*args)
      pdf?(*args) && process_upload?(*args)
    end

  end

end
