module Formtastic

  module Actions

    # Overwriting Base - formtastic/lib/formtastic/actions/base.rb
    module Base

      def button_html_from_options
        options[:button_html] ||= {}
        options[:button_html].merge(class: "btn btn-primary #{options[:button_html][:class]}")
      end

      def wrapper_html_options_from_options
        options[:wrapper_html] || { class: 'list-inline-item' }
      end

    end

  end

end
