module WrapActiveadmin

  # FileUploader
  module FileConcern

    extend ActiveSupport::Concern

    included do
      version :file_preview, if: :pdf? do
        process :cover,                     if: :process_upload?
        process resize_to_fill: [800, 800], if: :process_upload?
        process convert: :jpg,              if: :process_upload?

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

  end

end
