module CbStem

  module FileTypeIdentifier

    extend ActiveSupport::Concern

    included do
      def image?
        file_type&.start_with? 'image'
      end

      def video?
        file_type&.start_with? 'video'
      end

      def audio?
        file_type&.start_with? 'audio'
      end

      def file?
        !image? && !video? && !audio?
      end

      def file_type_eq
        if image?    then :image
        elsif video? then :video
        elsif audio? then :audio
        else :file
        end
      end
    end

  end

end
