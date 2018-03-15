module ActiveAdmin

  module Inputs

    module Filters

      module Base

        # Overwriting SearchMethodSelect -
        # activeadmin/lib/active_admin/inputs/filters/base/search_method_select.rb
        module SearchMethodSelect

          INPUT_CLASS = 'form-control'.freeze

          def wrapper_html_options
            opts = super
            (opts[:class] ||= '') << ' select_and_search' unless seems_searchable?
            opts
          end

          def to_html
            input_wrapping do
              label_html <<
                fields_html
            end
          end

          def fields_html
            template.content_tag :div, class: 'row' do
              template.content_tag(:div, select_html, class: 'col-md-6') <<
                template.content_tag(:div, input_html, class: 'col-md-6')
            end
          end

          def input_html
            builder.text_field current_filter, input_html_options
          end

          def select_html
            template.content_tag :div, class: 'select-wrap' do
              template.select_tag(
                '', template.options_for_select(filter_options, current_filter),
                class: INPUT_CLASS
              )
            end
          end

        end

      end

    end

  end

end
