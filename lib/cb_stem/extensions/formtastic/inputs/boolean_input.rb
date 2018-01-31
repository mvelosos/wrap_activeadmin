module Formtastic

  module Inputs

    # Overwriting BooleanInput - formtastic/lib/formtastic/inputs/boolean_input.rb
    class BooleanInput

      include Base

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

      def label_html_options
        {
          for: input_html_options[:id],
          class: super[:class] - ['label'] + ['form-check-label']
        }
      end

      def wrapper_classes
        classes = wrapper_classes_raw
        classes << as
        classes << 'input form-check form-group'
        classes << 'error' if errors?
        classes << 'optional' if optional?
        classes << 'required' if required?
        classes << 'autofocus' if autofocus?

        classes.join(' ')
      end

      def input_html_options
        {
          id: dom_id,
          class: 'form-check-input',
          required: required_attribute?,
          autofocus: autofocus?,
          readonly: readonly?
        }.merge(options[:input_html] || {})
      end

    end

  end

end
