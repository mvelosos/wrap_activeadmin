module Formtastic

  module Inputs

    module Base

      # Overwriting HTML - formtastic/lib/formtastic/inputs/base/html.rb
      module Html

        def input_html_options
          {
            id: dom_id,
            class: 'form-control',
            required: required_attribute?,
            autofocus: autofocus?,
            readonly: readonly?
          }.merge(options[:input_html] || {})
        end

      end

    end

  end

end
