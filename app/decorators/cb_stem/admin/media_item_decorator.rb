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
        content_tag :div, class: 'd-flex flex-row align-items-center' do
          concat(
            content_tag(:div, aa_icon('folder-14'),
                        class: 'thumbnail border text-primary mr-2 xs')
          )
          concat(content_tag(:span, name, class: 'identifier-text'))
        end
      end

      def items_count
        return if object.items_count.zero?
        t('.cb_stem.media_items.inventory', count: object.items_count)
      end

      def file_size
        number_to_human_size(object.file_size, precision: 2)
      end

      private

      def folder_identifier
        link_to [:admin, :cb_stem, :media_items, parent_id: object],
                class: 'table-item-identifier folder-item' do
          concat(
            content_tag(:div, render('cb_stem/svgs/folder.svg'),
                        class: 'thumbnail mr-2')
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
            content_tag(:div, aa_icon('single-content-02'),
                        class: 'thumbnail transparent mr-2')
          )
          concat(content_tag(:span, name, class: 'identifier-text'))
        end
      end

    end

  end

end
