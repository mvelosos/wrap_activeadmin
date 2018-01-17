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

      WRAPPER_CLASS = 'card mb-3'.freeze
      HEADING_CLASS = 'card-header'.freeze
      BODY_CLASS    = 'card-body'.freeze

      def build(_form_builder, *args, &block)
        html_options = args.extract_options!
        html_options[:class] ||= "inputs #{WRAPPER_CLASS}"
        legend = args.shift if args.first.is_a?(::String)
        legend = html_options.delete(:name) if html_options.key?(:name)
        legend_tag = legend ? title_tag(legend) : ''
        fieldset_attrs = html_options.map { |k, v| %(#{k}="#{v}") }.join(' ')
        @opening_tag = "<div #{fieldset_attrs}>#{legend_tag}<div class=#{BODY_CLASS}>"
        @closing_tag = '</div></div>'
        super(*(args << html_options), &block)
      end

      private

      def title_tag(legend)
        "<h5 class=#{HEADING_CLASS}>#{legend}</h5>"
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
