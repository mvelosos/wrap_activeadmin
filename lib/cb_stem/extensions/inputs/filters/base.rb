module ActiveAdmin

  module Inputs

    module Filters

      # Overwriting Filters::Base - activeadmin/lib/active_admin/inputs/filters/base.rb
      module Base

        LABEL_CLASS   = 'control-label'.freeze
        INPUT_CLASS   = 'form-control'.freeze
        WRAPPER_CLASS = 'form-group'.freeze

        def label_html_options
          {
            for: input_html_options[:id],
            class: [LABEL_CLASS]
          }
        end

        def input_html_options
          {
            class: INPUT_CLASS
          }
        end

        def wrapper_html_options
          opts = super
          (opts[:class] ||= '') << " #{WRAPPER_CLASS} filter_form_field filter_#{as}"
          opts
        end

      end

    end

  end

end
