module ActiveAdmin

  # modified from https://github.com/DynamoMTL/activeadmin-sortable.git
  module Sortable

    # Extend ActiveAdmin Controllers
    module ControllerActions

      # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      def sortable
        member_action :sort, method: :post do
          if defined?(::Mongoid::Orderable) &&
             resource.class.included_modules.include?(::Mongoid::Orderable)
            resource.move_to! params[:position].to_i
          else
            resource.insert_at params[:position].to_i
          end
          flash[:notice] =
            t('wrap_activeadmin.active_admin_sortable.update.success',
              model: resource.class.model_name.human)
          flash = render_to_string partial: 'wrap_activeadmin/components/flash', layout: false
          render json: flash.to_json, status: :ok
        end
      end
      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    end

    # Extend TableMethods
    module TableMethods

      def sortable_handle_column(url: nil, order_by: 'position', order_dir: 2)
        column '', class: 'activeadmin-sortable' do |resource|
          position = resource.send(order_by.to_sym)
          div class: 'handle',
              'data-sort-url': url.presence || url_for([:sort, :admin, resource]),
              'data-position': position,
              'data-order': order_dir do
            handle_icon
          end
        end
      end

    end

    ::ActiveAdmin::ResourceDSL.send(:include, ControllerActions)
    ::ActiveAdmin::Views::TableFor.send(:include, TableMethods)

  end

end
