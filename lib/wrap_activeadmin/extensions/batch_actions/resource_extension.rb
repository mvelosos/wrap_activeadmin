module ActiveAdmin

  module BatchActions

    # Overwriting BatchAction - activeadmin/lib/active_admin/batch_actions/resource_extension.rb
    module ResourceExtension

      private

      # rubocop:disable all
      def add_default_batch_action
        destroy_options = {
          priority: 100,
          confirm: proc { I18n.t('wrap_activeadmin.batch_actions.title') },
          message: proc { I18n.t('active_admin.batch_actions.delete_confirmation', plural_model: active_admin_config.plural_resource_label.downcase) },
          if: proc { controller.action_methods.include?('destroy') && authorized?(ActiveAdmin::Auth::DESTROY, active_admin_config.resource_class) }
        }

        add_batch_action :destroy, proc { I18n.t('active_admin.delete') }, destroy_options do |selected_ids|
          batch_action_collection.find(selected_ids).each do |record|
            authorize! ActiveAdmin::Auth::DESTROY, record
            destroy_resource(record)
          end

          redirect_to active_admin_config.route_collection_path(params),
                      notice: I18n.t('active_admin.batch_actions.succesfully_destroyed',
                                     count: selected_ids.count,
                                     model: active_admin_config.resource_label.downcase,
                                     plural_model: active_admin_config.plural_resource_label(count: selected_ids.count).downcase)
        end
      end

    end

  end

  # Overwrite BatchAction
  class BatchAction

    def confirm
      if @confirm == true
        DEFAULT_CONFIRM_MESSAGE
      elsif !@confirm && (@options[:form] || @options[:batch_form])
        DEFAULT_CONFIRM_MESSAGE
      else
        @confirm
      end
    end

    def message
      @options[:message]
    end

    def batch_form
      @options[:batch_form]
    end

  end

end
