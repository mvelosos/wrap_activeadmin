if CbStem.enable_media_library
  ActiveAdmin.register CbStem::FolderItem do
    menu false

    actions :destroy

    # ACTIONS
    collection_action :new_folder, method: :get do
      parent  = CbStem::FolderItem.find_by(id: params[:parent_id])
      @folder = CbStem::FolderItem.new
      @folder.parent = parent if parent.present?
    end

    collection_action :create_folder, method: :post do
      @folder = CbStem::FolderItem.new(folder_params)
      if @folder.save
        flash[:notice] = t('.success', name: @folder.name)
        render 'save'
      else
        render 'save_error'
      end
    end

    member_action :edit_folder, method: :get do
      @folder = CbStem::FolderItem.find_by(id: params[:id])
    end

    member_action :update_folder, method: :patch do
      @folder = CbStem::FolderItem.find_by(id: params[:id])
      @folder.assign_attributes(folder_params)
      if @folder.save
        flash[:notice] = t('.success', name: @folder.name)
        render 'save'
      else
        render 'save_error'
      end
    end

    # CONTROLLER
    controller do
      def destroy
        destroy! do |success, _failure|
          success.html { redirect_back fallback_location: %i[admin cb_stem media_items] }
        end
      end

      def folder_params
        params.fetch(:folder_item, {}).permit(
          :name, :parent_id
        )
      end
    end
  end
end
