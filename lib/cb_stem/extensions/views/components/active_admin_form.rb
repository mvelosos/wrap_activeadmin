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

      def build(_form_builder, *args, &block)
        html_options = args.extract_options!
        html_options[:class] ||= 'inputs'
        legend = args.shift if args.first.is_a?(::String)
        legend = html_options.delete(:name) if html_options.key?(:name)
        legend_tag = legend ? title_tag(legend) : ''
        fieldset_attrs = html_options.map { |k, v| %(#{k}="#{v}") }.join(' ')
        @opening_tag = "<div #{fieldset_attrs}>#{legend_tag}<div>"
        @closing_tag = '</div></div>'
        super(*(args << html_options), &block)
      end

      private

      def title_tag(legend)
        "<h5>#{legend}</h5>"
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
