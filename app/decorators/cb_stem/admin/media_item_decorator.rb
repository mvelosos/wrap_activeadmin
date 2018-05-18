module CbStem

  module Admin

    # Decorates CbStem::MediaItem Object
    class MediaItemDecorator < ApplicationDecorator

      decorates 'cb_stem/media_item'

      def identifier
        if object.type == 'CbStem::FileItem'
          media_identifier
        else
          folder_identifier
        end
      end

      def select_item_template
        content_tag :div, class: 'table-item-identifier' do
          concat(content_tag(:div, render('cb_stem/svgs/folder.svg'),
                             class: 'thumbnail mr-2 transparent xs'))
          concat(
            content_tag(:div, class: 'identifier-text text-decoration-none') do
              content_tag(:span, "[#{reference_key}]", class: 'mr-1 text-secondary') +
                content_tag(:span, name)
            end
          )
        end
      end

      def file_size
        number_to_human_size(object.file_size, precision: 2)
      end

      private

      def folder_identifier
        link_to [:admin, :cb_stem, :media_items, parent_id: object],
                class: 'table-item-identifier' do
          concat(
            content_tag(:div, render('cb_stem/svgs/folder.svg'),
                        class: 'thumbnail mr-2 transparent')
          )
          concat(content_tag(:span, name, class: 'identifier-text'))
        end
      end

      def media_identifier
        if image?
          image_identifier
        else
          file_identifier
        end
      end

      def image_identifier
        link_to [:admin, :cb_stem, :media_items, parent_id: object],
                class: 'table-item-identifier file-item' do
          concat(thumbnail(object, 'file', class: 'mr-2', icon: 'single-02'))
          concat(content_tag(:span, name, class: 'identifier-text'))
        end
      end

      def file_identifier
        link_to [:admin, :cb_stem, :media_items, parent_id: object],
                class: 'table-item-identifier file-item' do
          concat(
            content_tag(:div, render('cb_stem/svgs/file.svg'),
                        class: 'thumbnail mr-2 transparent')
          )
          concat(content_tag(:span, name, class: 'identifier-text'))
        end
      end

    end

  end

end
