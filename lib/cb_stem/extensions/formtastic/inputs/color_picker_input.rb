module Formtastic

  module Inputs

    # Custom Color Picker Input
    class ColorPickerInput < Formtastic::Inputs::StringInput

      def html_input_type
        'text'
      end

      def input_html_options
        super.merge(class: 'form-control minicolors')
      end

    end

  end

end
