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

      # rubocop:disable Style/PredicateName
      def has_many(*args, &block)
        insert_tag(HasManyProxy, form_builder, *args, &block)
      end

    end

    # Overwriting SemanticInputsProxy
    class SemanticInputsProxy < FormtasticProxy

      # rubocop:disable Metrics/LineLength, Metrics/AbcSize
      def build(_form_builder, *args, &block)
        html_options = args.extract_options!
        card         = html_options.delete(:card) { true }
        html_options[:class] ||= inputs_klass(card)
        legend = args.shift if args.first.is_a?(::String)
        legend = html_options.delete(:name) if html_options.key?(:name)
        fieldset_attrs = html_options.map { |k, v| %(#{k}="#{v}") }.join(' ')
        @opening_tag = "<div #{fieldset_attrs}>#{legend_tag(legend)}<div class=#{inputs_body_klass(card)}><ol class='list-unstyled'>"
        @closing_tag = '</ol></div></div>'
        super(*(args << html_options), &block)
      end

      private

      def inputs_klass(card)
        klass = %w[inputs mb-3]
        klass.push 'card' if card
        klass.join(' ')
      end

      def inputs_body_klass(card)
        card ? 'card-body' : 'inputs-body'
      end

      def legend_tag(legend)
        return if legend.blank?
        "<h5 class='card-header'>#{legend}</h5>"
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
