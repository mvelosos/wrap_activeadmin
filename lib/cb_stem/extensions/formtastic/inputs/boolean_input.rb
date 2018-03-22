module Formtastic

  module Inputs

    # Overwriting BooleanInput - formtastic/lib/formtastic/inputs/boolean_input.rb
    class BooleanInput

      def to_html
        input_wrapping do
          template.content_tag :div, class: 'input-checkbox' do
            hidden_field_html +
              check_box_html +
              label_html
          end
        end
      end

      def label_html
        builder.label(
          method,
          template.content_tag(:span, label_text),
          label_html_options
        )
      end

      def label_html_options
        {
          for: input_html_options[:id],
          class: super[:class] - ['label'] + ['checkbox-icon']
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
          name: input_html_options_name,
          class: 'form-check-input'
        }.reverse_merge!(super)
      end

    end

  end

end
