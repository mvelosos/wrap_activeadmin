module Formtastic

  module Inputs

    # Custom SwitchInput
    class SwitchInput < BooleanInput

      def to_html
        input_wrapping do
          template.content_tag(:div, toggle_html_options) do
            hidden_field_html +
              check_box_with_label_html
          end
        end
      end

      def label_html
        builder.label(
          method,
          switch_html,
          label_html_options
        )
      end

      def switch_html
        template.content_tag(:span, label_text, class: 'switch-text') +
          template.content_tag(:span, '', class: 'switch-btn')
      end

      def check_box_with_label_html
        check_box_html << '' << label_html
      end

      def toggle_html_options
        options[:toggle_html] ||= {}
        options[:toggle_html][:class] = "#{options[:toggle_html][:class]} form-switch"
        options[:toggle_html]
      end

      def label_html_options
        {
          for: input_html_options[:id],
          class: super[:class] - %w[label checkbox-icon control-label] + %w[form-switch-label]
        }
      end

      def wrapper_classes
        classes = wrapper_classes_raw
        classes << as
        classes << 'input form-group'
        classes << 'error'     if errors?
        classes << 'optional'  if optional?
        classes << 'required'  if required?
        classes << 'autofocus' if autofocus?

        classes.join(' ')
      end

      def input_html_options
        {
          name: input_html_options_name,
          class: 'form-switch-input'
        }.reverse_merge!(super)
      end

    end

  end

end
