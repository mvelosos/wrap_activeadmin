module Formtastic

  module Inputs

    module Base

      # Overwriting Labelling - formtastic/lib/formtastic/inputs/base/labelling.rb
      module Labelling

        def label_html_options
          {
            for: input_html_options[:id],
            class: ['control-label']
          }
        end

      end

    end

  end

end
