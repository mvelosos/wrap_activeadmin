module Formtastic

  module Inputs

    # Custom SwitchInput
    class SwitchInput < BooleanInput

      def to_html
        input_wrapping do
          hidden_field_html +
            check_box_html +
            label_html
        end
      end

      def label_html
        builder.label(
          method,
          label_text,
          label_html_options
        )
      end

      def input_wrapping(&block)
        template.content_tag(:div, wrapper_html_options) do
          template.content_tag(
            :span,
            [template.capture(&block), error_html, hint_html].join("\n")&.html_safe,
            toggle_html_options
          )
        end
      end

      def toggle_html_options
        options[:toggle_html] ||= {}
        options[:toggle_html][:class] = "#{options[:toggle_html][:class]} form-switch"
        options[:toggle_html]
      end

      def label_html_options
        {
          for: input_html_options[:id],
          class: super[:class] - ['label'] + ['form-switch-label']
        }
      end

      def wrapper_classes
        classes = wrapper_classes_raw
        classes << as
        classes << 'input form-group'
        classes << 'error' if errors?
        classes << 'optional' if optional?
        classes << 'required' if required?
        classes << 'autofocus' if autofocus?

        classes.join(' ')
      end

      def input_html_options
        {
          id: dom_id,
          class: 'form-switch-input',
          required: required_attribute?,
          autofocus: autofocus?,
          readonly: readonly?
        }.merge(options[:input_html] || {})
      end

    end

  end

end
