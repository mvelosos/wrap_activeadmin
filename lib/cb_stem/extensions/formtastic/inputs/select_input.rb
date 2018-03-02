module Formtastic

  module Inputs

    # Overwriting SelectInput - formtastic/lib/formtastic/inputs/select_input.rb
    class SelectInput

      def select_html
        template.content_tag :div, class: 'select-wrap' do
          builder.select(input_name, collection, input_options, input_html_options)
        end
      end

    end

  end

end
