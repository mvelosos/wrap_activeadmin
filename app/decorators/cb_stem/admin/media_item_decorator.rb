module CbStem

  module Admin

    # Decorates CbStem::MediaItem Object
    class MediaItemDecorator < ApplicationDecorator

      decorates 'cb_stem/media_item'

      def identifier
        link_to [:admin, :cb_stem, :media_items, parent_id: object],
                class: 'table-item-identifier' do
          concat(
            content_tag(:div, aa_icon('folder-14'),
                        class: 'thumbnail transparent text-primary mr-1')
          )
          concat(content_tag(:span, name, class: 'identifier-text'))
        end
      end

      def select_item_template
        content_tag :div, class: 'd-flex flex-row align-items-center' do
          concat(
            content_tag(:div, aa_icon('folder-14'),
                        class: 'thumbnail transparent text-primary mr-1 xs')
          )
          concat(content_tag(:span, name, class: 'identifier-text'))
        end
      end

      def items_count
        return if object.items_count.zero?
        t('.cb_stem.media_items.inventory', count: object.items_count)
      end

    end

  end

end
