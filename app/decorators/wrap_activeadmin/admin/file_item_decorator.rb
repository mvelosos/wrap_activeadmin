module WrapActiveadmin

  module Admin

    # Decorates WrapActiveadmin::MediaItem Object
    class FileItemDecorator < WrapActiveadmin::Admin::MediaItemDecorator

      decorates 'wrap_activeadmin/file_item'

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
