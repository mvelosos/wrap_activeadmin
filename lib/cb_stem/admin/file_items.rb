if CbStem.enable_media_library
  ActiveAdmin.register CbStem::FileItem do
    menu false

    actions :destroy

    # ACTIONS
    collection_action :drop_upload, method: :post do
      parent = CbStem::FolderItem.find_by(id: upload_params[:parent_id])
      file   = CbStem::FileItem.new(file: params['file'])
      file.parent = parent if parent.present?
      file.save ? head(200) : head(500)
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
  end
end
