module ActiveAdmin

  module Views

    # Overwriting Footer - activeadmin/lib/active_admin/views/footer.rb
    class Footer < Component

      WRAPPER_CLASS = 'text-center text-muted'.freeze

      def build(namespace)
        super(id: 'footer', class: WRAPPER_CLASS)
        @namespace = namespace

        hr
        if footer?
          small footer_text
        else
          small powered_by_message
        end
      end

      private

      def powered_by_message
        I18n.t('cb_stem.powered_by',
               year: Time.zone.now.year,
               owner: t('cb_stem.owner'),
               version: CbStem::VERSION)
      end

    end

  end

end
