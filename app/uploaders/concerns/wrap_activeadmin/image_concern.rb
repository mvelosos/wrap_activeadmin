module WrapActiveadmin

  # ImageUploader
  module ImageConcern

    extend ActiveSupport::Concern

    included do
      process resize_to_fit: [3000, 3000], if: :image?

      # Mobile version
      version :sm do
        process resize_to_fit: [600, 600], if: :should_process_image?
      end

      # medium version
      version :md do
        process resize_to_fit: [1200, 1200], if: :should_process_image?
      end

      # Desktop version
      version :lg do
        process resize_to_fit: [2400, 2400], if: :should_process_image?
      end

      version :thumb do
        process resize_to_fit: [128, 128], if: :should_process_image?
      end
    end

    def should_process_image?(*args)
      image?(*args) && process_upload?(*args)
    end

  end

end
