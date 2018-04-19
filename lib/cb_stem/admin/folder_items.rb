if CbStem.enable_media_library
  ActiveAdmin.register CbStem::FolderItem do
    menu false

    actions :destroy

    permit_params :title

    # ACTIONS
    collection_action :new_folder, method: :get do
      parent  = CbStem::FolderItem.find_by(id: params[:parent_id])
      @folder = CbStem::FolderItem.new
      @folder.parent = parent if parent.present?
    end

    collection_action :create_folder, method: :post do
      @folder = CbStem::FolderItem.new(folder_params)
      if @folder.save
        flash[:notice] = t('.success', name: @folder.title)
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
        flash[:notice] = t('.success', name: @folder.title)
        render 'save'
      else
        render 'save_error'
      end
    end

    # CONTROLLER
    controller do
      def folder_params
        params.fetch(:folder_item, {}).permit(
          :title, :parent_id
        )
      end
    end
  end
end
