module CbStem

  # Uploader For Medias
  class MediaUploader < CbStem::ApplicationUploader

    def default_url
      ActionController::Base.helpers.asset_path('cb_stem/default/media.png')
    end

    process resize_to_fit: [1000, 1000], if: :image?

    version :preview, if: :pdf? do
      process :pdf_cover
      process resize_to_fill: [800, 800]
      process convert: :jpg

      def full_filename(for_file = model.source.file)
        super.chomp(File.extname(super)) + '.jpg'
      end
    end

    version :thumb, if: :image? do
      process resize_to_fit: [256, 256]
    end

    version :medium, if: :image? do
      process resize_to_fit: [512, 512]
    end

    version :large, if: :image? do
      process resize_to_fit: [1024, 1024]
    end

    ## Mobile version
    version :mobile, if: :image? do
      process resize_to_fit: [300, 300]
    end

    # Tablet version
    version :tablet, if: :image? do
      process resize_to_fit: [600, 600]
    end

    # Desktop version
    version :desktop, if: :image? do
      process resize_to_fit: [800, 800]
    end

    def pdf_cover
      manipulate! do |frame, index|
        frame if index.zero?
      end
    end

    def extension_white_list
      %w[jpg jpeg gif png pdf doc docx json]
    end

  end

end
