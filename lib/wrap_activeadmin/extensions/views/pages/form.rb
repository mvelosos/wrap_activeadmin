module ActiveAdmin

  module Views

    module Pages

      # Overwriting Form activeadmin/lib/active_admin/views/pages/form.rb
      class Form < Base

        def form_presenter
          active_admin_config.get_page_presenter(:form) || default_form_config
        end

        # rubocop:disable Metrics/AbcSize
        def main_content
          options = default_form_options.merge form_presenter.options

          if options[:partial]
            render options[:partial]
          elsif options[:multiple]
            instance_exec(&form_presenter.block)
          else
            active_admin_form_for resource, options, &form_presenter.block
          end
        end

        alias form_section active_admin_form_for

      end

    end

  end

end
