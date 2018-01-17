module ActiveAdmin

  module Filters

    # This module is included into the view
    module ViewHelper

      WRAPPER_CLASS     = 'form-group'.freeze
      PRIMARY_BTN_CLASS = 'btn btn-primary'.freeze
      BTN_CLASS         = 'btn btn-secondary clear_filters_btn'.freeze

      # rubocop:disable Metrics/AbcSize
      def active_admin_filters_form_for(search, filters, options = {})
        options = defaults.deep_merge(options).deep_merge(required)

        form_for search, options do |f|
          filters.each do |attribute, opts|
            next if opts.key?(:if)     && !call_method_or_proc_on(self, opts[:if])
            next if opts.key?(:unless) &&  call_method_or_proc_on(self, opts[:unless])
            opts[:input_html] = instance_exec(&opts[:input_html]) if opts[:input_html].is_a?(Proc)
            f.filter attribute, opts.except(:if, :unless)
          end

          f.template.concat buttons(f)
        end
      end

      private

      def defaults
        {
          builder: ActiveAdmin::Filters::FormBuilder,
          url: collection_path,
          html: { class: 'filter_form' }
        }
      end

      def required
        {
          html: { method: :get },
          as: :q
        }
      end

      def buttons(f)
        content_tag :div, class: "buttons #{WRAPPER_CLASS}" do
          content_tag :ul, class: 'list-inline' do
            wrap_button { cancel_button } +
              wrap_button { submit_button(f) } +
              hidden_field_tags_for(params, except: except_hidden_fields)
          end
        end
      end

      def wrap_button
        content_tag :li, class: 'list-inline-item' do
          yield
        end
      end

      def submit_button(f)
        f.submit(
          I18n.t('active_admin.filters.buttons.filter'),
          class: PRIMARY_BTN_CLASS
        )
      end

      def cancel_button
        link_to(
          I18n.t('active_admin.filters.buttons.clear'), '#',
          class: BTN_CLASS
        )
      end

    end

  end

end
