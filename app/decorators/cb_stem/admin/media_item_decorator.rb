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
          concat(content_tag(:span, title, class: 'identifier-text'))
        end
      end

      def items_count
        return if object.items_count.zero?
        t('.cb_stem.media_items.inventory', count: object.items_count)
      end

    end

  end

end
