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
            t('cb_stem.active_admin_sortable.update.success',
              model: resource.class.model_name.human)
          flash = render_to_string partial: 'cb_stem/components/flash', layout: false
          render json: flash.to_json, status: :ok
        end
      end
      # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    end

    # Extend TableMethods
    module TableMethods

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def sortable_handle_column
        column '', class: 'activeadmin-sortable' do |resource|
          sort_url, query_params = resource_path(resource).split '?', 2
          sort_url += '/sort'
          sort_url += '?' + query_params if query_params
          order_by, order_dir = params[:order].split '_', 2
          position = resource.send(order_by.to_sym)
          div class: 'handle',
              'data-sort-url': sort_url,
              'data-position': position,
              'data-order': order_dir do
            handle_icon
          end
        end
      end
      # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

      def handle_icon
        render('cb_stem/svgs/sortable_handle.svg')
      end

    end

    ::ActiveAdmin::ResourceDSL.send(:include, ControllerActions)
    ::ActiveAdmin::Views::TableFor.send(:include, TableMethods)

  end

end
