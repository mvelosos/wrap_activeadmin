module ActiveAdmin

  module Inputs

    module Filters

      # Overwriting DateRangeInput -
      # activeadmin/lib/active_admin/inputs/filters/date_range_input.rb
      class DateRangeInput < ::Formtastic::Inputs::StringInput

        include Base

        INPUT_CLASS = 'datepicker form-control'.freeze

        def to_html
          input_wrapping do
            [
              label_html,
              fields
            ].join("\n")&.html_safe
          end
        end

        def input_html_options(input_name = gt_input_name, placeholder = gt_input_placeholder)
          {
            size: 12,
            class: INPUT_CLASS,
            maxlength: 10,
            placeholder: placeholder,
            value: current_value(input_name) ? current_value(input_name).strftime('%Y-%m-%d') : ''
          }
        end

        def fields
          template.content_tag :div, class: 'row' do
            template.content_tag(:div, gt_input, class: 'col-md-6') <<
              template.content_tag(:div, lt_input, class: 'col-md-6')
          end
        end

        private

        def gt_input
          builder.text_field(gt_input_name, input_html_options(gt_input_name, gt_input_placeholder))
        end

        def lt_input
          builder.text_field(lt_input_name, input_html_options(lt_input_name, lt_input_placeholder))
        end

        def current_value(input_name)
          @object.public_send(input_name).to_s.to_date
        rescue
          nil
        end

      end

    end

  end

end
