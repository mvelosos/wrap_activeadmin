module Formtastic

  module Inputs

    module Base

      # Overwriting Timeish - formtastic/lib/formtastic/inputs/base/timeish.rb
      module Timeish

        # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        def fragment_input_html(fragment)
          opts  =
            input_options.merge(
              prefix: fragment_prefix,
              field_name: fragment_name(fragment),
              default: value,
              include_blank: include_blank?
            )
          klass = %w[select-wrap]
          klass = klass.join(' ')
          template.content_tag :div, class: klass do
            template.send(
              :"select_#{fragment}",
              value, opts,
              input_html_options.merge(id: fragment_id(fragment))
            )
          end
        end

      end

    end

  end

end
