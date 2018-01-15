module Formtastic

  module Actions

    # Overwriting Base - formtastic/lib/formtastic/actions/base.rb
    module Base

      def button_html_from_options
        options[:button_html] ||= {}
        options[:button_html].merge(class: 'btn btn-primary')
      end

    end

  end

end
