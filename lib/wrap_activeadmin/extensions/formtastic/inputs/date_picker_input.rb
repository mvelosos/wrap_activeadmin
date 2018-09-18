module Formtastic

  module Inputs

    # Overwriting DatePickerInput - formtastic/lib/formtastic/inputs/date_picker_input.rb
    class DatePickerInput

      def html_input_type
        'text'
      end

      def input_html_options
        super.merge(class: 'form-control datepicker')
      end

    end

  end

end
