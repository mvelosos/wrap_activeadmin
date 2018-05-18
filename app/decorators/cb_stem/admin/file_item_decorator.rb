module CbStem

  module Admin

    # Decorates CbStem::MediaItem Object
    class FileItemDecorator < CbStem::Admin::MediaItemDecorator

      decorates 'cb_stem/file_item'

      def preview
        case file_type_eq
        when :image
          image_tag file_url(:tablet), class: 'mw-100'
        when :video
          video_tag file_url, controls: true, autobuffer: true, class: 'mw-100'
        else
          content_tag :div, class: 'table-item-identifier' do
            file_identifier
          end
        end
      end

    end

  end

end
