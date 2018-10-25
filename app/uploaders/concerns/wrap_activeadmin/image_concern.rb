module WrapActiveadmin

  # ImageUploader
  module ImageConcern

    extend ActiveSupport::Concern

    included do
      process resize_to_fit: [3000, 3000], if: :image?

      # Mobile version
      version :sm, if: :image? do
        process resize_to_fit: [600, 600], if: :process_upload?
      end

      # medium version
      version :md, if: :image? do
        process resize_to_fit: [1200, 1200], if: :process_upload?
      end

      # Desktop version
      version :lg, if: :image? do
        process resize_to_fit: [2400, 2400], if: :process_upload?
      end

      version :thumb, if: :image? do
        process resize_to_fit: [128, 128], if: :process_upload?
      end
    end

  end

end
