module Formtastic

  module Inputs

    # Overwriting SelectInput - formtastic/lib/formtastic/inputs/select_input.rb
    class SelectInput

      def select_html
        multiple = input_html_options[:multiple]
        klass    = %w[select-wrap]
        klass.push 'multiple' if multiple
        klass = klass.join(' ')
        template.content_tag :div, class: klass do
          builder.select(input_name, collection, input_options, input_html_options)
        end
      end

    end

  end

end
