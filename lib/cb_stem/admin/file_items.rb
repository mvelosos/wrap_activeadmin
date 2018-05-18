if CbStem.enable_media_library
  ActiveAdmin.register CbStem::FileItem do
    decorate_with CbStem::Admin::FileItemDecorator
    menu false

    actions :show, :destroy

    # ACTIONS
    collection_action :drop_upload, method: :post do
      parent = CbStem::FolderItem.find_by(id: upload_params[:parent_id])
      file   = CbStem::FileItem.new(file: params['file'])
      file.parent = parent if parent.present?
      file.save ? head(200) : head(500)
    end

    # BREADCRUMBS
    breadcrumb do
      parent = CbStem::MediaItem.find_by id: params[:parent_id]
      links  = []
      if parent.present?
        links += [
          link_to(t('cb_stem.menu.media_items'), admin_cb_stem_media_items_path)
        ]
        links +=
          parent.ancestors.collect do |x|
            link_to(x.name, admin_cb_stem_media_items_path(parent_id: x.parent_id))
          end
      end
      links
    end

    # CONTROLLER
    controller do
      def destroy
        destroy! do |success, _failure|
          success.html { redirect_back fallback_location: %i[admin cb_stem media_items] }
        end
      end

      private

      def upload_params
        params.fetch(:drop_upload, {}).permit(
          :parent_id
        )
      end
    end

    # SHOW
    sidebar '', only: :show do
      attributes_table_for resource do
        row :name
        row :reference_key
        row :file_size
        row :file_type
        row :created_at
        row :updated_at
      end
    end

    show do
      panel do
        resource.preview
      end

      active_admin_comments
    end
  end
end
