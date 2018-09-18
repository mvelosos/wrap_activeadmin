module Formtastic

  module Inputs

    # Overwriting JustDatetimePickerInput -
    # just-datetime-picker/lib/just-datetime-picker/formtastic-input.rb
    class JustDatetimePickerInput

      include ::Formtastic::Inputs::Base

      TIME_FORMAT = '%02d'.freeze

      def to_html
        input_wrapping do
          label_html << input_html
        end
      end

      private

      def input_html
        template.content_tag :div, class: 'input-fragments' do
          date_field << hour_field << time_divider << minute_field
        end
      end

      def time_divider
        template.content_tag :span, ':', class: 'input-fragment'
      end

      def date_field
        builder.text_field(
          "#{method}_date",
          input_html_options.merge(
            class: 'form-control datepicker input-fragment fragment-date',
            value: builder.object.send("#{method}_date"), maxlength: 10, size: 10
          )
        )
      end

      def hour_field
        builder.text_field(
          "#{method}_time_hour",
          input_html_options.merge(
            class: 'form-control input-fragment fragment-time',
            value: hour_value, maxlength: 2, size: 2
          )
        )
      end

      def minute_field
        builder.text_field(
          "#{method}_time_minute",
          input_html_options.merge(
            class: 'form-control input-fragment fragment-time',
            value: minute_value, maxlength: 2, size: 2
          )
        )
      end

      def combined_value
        builder.object.send(method)
      end

      def hour_value
        hour_value_raw = builder.object.send("#{method}_time_hour")
        value =
          if !hour_value_raw.nil?
            hour_value_raw
          elsif !combined_value.nil?
            combined_value.hour
          else
            '00'
          end
        format(TIME_FORMAT, value)
      end

      def minute_value
        minute_value_raw = builder.object.send("#{method}_time_minute")
        value =
          if !minute_value_raw.nil?
            minute_value_raw
          elsif !combined_value.nil?
            combined_value.min
          else
            '00'
          end
        format(TIME_FORMAT, value)
      end

    end

  end

end
