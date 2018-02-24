module ActiveAdmin

  module Views

    # Overwriting ActiveAdminForm -
    # activeadmin/lib/active_admin/views/components/active_admin_form.rb
    class ActiveAdminForm < FormtasticProxy

      def commit_action_with_cancel_link
        add_create_another_checkbox
        cancel_link
        action(:submit)
      end

    end

    # Overwriting SemanticInputsProxy
    class SemanticInputsProxy < FormtasticProxy

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def build(_form_builder, *args, &block)
        html_options = args.extract_options!
        html_options[:class] ||= 'inputs row'
        legend      = args.shift if args.first.is_a?(::String)
        legend      = html_options.delete(:name) if html_options.key?(:name)
        hint        = html_options.delete(:hint) if html_options.key?(:hint)
        body_tag    = hint ? hint_tag(hint) : ''
        legend_tag  = legend ? title_tag(legend) : ''
        fieldset_attrs = html_options.map { |k, v| %(#{k}="#{v}") }.join(' ')
        @opening_tag =
          "<div #{fieldset_attrs}>" \
          "#{title_html(legend_tag, body_tag)}<div class='col'>"
        @closing_tag = '</div></div>'
        super(*(args << html_options), &block)
      end

      private

      def title_html(legend_tag, body_tag)
        return if (legend_tag + body_tag).blank?
        "<div class='col-md-5'>#{legend_tag}#{body_tag}</div>"
      end

      def title_tag(legend)
        "<h6>#{legend}</h6>"
      end

      def hint_tag(hint)
        hint&.html_safe
      end

    end

    # Overwriting SemanticActionsProxySemanticActionsProxy
    class SemanticActionsProxy < FormtasticProxy

      def build(_form_builder, *args, &block)
        @opening_tag = '<div class="actions form-group"><ul class="list-inline">'
        @closing_tag = '</ul></div>'
        super(*args, &block)
      end

    end

  end

end
