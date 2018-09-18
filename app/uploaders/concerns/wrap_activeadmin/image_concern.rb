module WrapActiveadmin

  # ImageUploader
  module ImageConcern

    extend ActiveSupport::Concern

    included do
      process resize_to_fit: [3000, 3000], if: :image?

      # Mobile version
      version :sm, if: :image? do
        process resize_to_fit: [600, 600]
      end

      # medium version
      version :md, if: :image? do
        process resize_to_fit: [1200, 1200]
      end

      # Desktop version
      version :lg, if: :image? do
        process resize_to_fit: [2400, 2400]
      end

      version :thumb, if: :image? do
        process resize_to_fit: [128, 128]
      end
    end

  end

end
