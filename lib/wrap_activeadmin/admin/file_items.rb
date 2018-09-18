if WrapActiveadmin.enable_media_library
  ActiveAdmin.register WrapActiveadmin::FileItem do
    decorate_with WrapActiveadmin::Admin::FileItemDecorator
    menu false

    actions :show, :destroy

    # ACTIONS
    action_item :download, only: :show do
      action_btn(
        t('.wrap_activeadmin.media_items.download'),
        resource.file_url,
        target: '_blank',
        icon: 'square-download',
        title: false
      )
    end

    # BREADCRUMBS
    breadcrumb do
      parent = WrapActiveadmin::MediaItem.find_by id: params[:parent_id]
      links  = []
      if parent.present?
        links += [
          link_to(t('wrap_activeadmin.menu.media_items'), admin_wrap_activeadmin_media_items_path)
        ]
        links +=
          parent.ancestors.collect do |x|
            link_to(x.name, admin_wrap_activeadmin_media_items_path(parent_id: x.parent_id))
          end
      end
      links
    end

    # CONTROLLER
    member_action :drop_update, method: :patch do
      resource.file = params['file']
      if resource.save
        @status = :ok
      else
        flash[:error] = file.errors.messages[:file][0..0]
        @status       = :internal_server_error
        @msg          = render_to_string partial: 'wrap_activeadmin/components/flash', layout: false
      end
      render text: @msg, status: @status
    end

    collection_action :drop_upload, method: :post do
      parent = WrapActiveadmin::FolderItem.find_by(id: upload_params[:parent_id])
      file   = WrapActiveadmin::FileItem.new(file: params['file'])
      file.parent = parent if parent.present?
      if file.save
        @status = :ok
      else
        @status = :internal_server_error
        @msg    = file.errors.messages[:file][0..0]
      end
      render json: @msg, status: @status
    end

    controller do
      def destroy
        destroy! do |success, _failure|
          success.html { redirect_back fallback_location: %i[admin wrap_activeadmin media_items] }
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
    html_content :dropzone, only: :show do
      div id: 'media-items-upload', class: 'mb-3' do
        active_admin_form_for resource,
                              url: [:drop_update, :admin, :wrap_activeadmin, resource],
                              method: :patch,
                              html: {
                                id: 'drop-holder',
                                data: { 'dropzone-clickable': '.dropzone-btn' }
                              }
      end
    end

    sidebar '', only: :show do
      div do
        link_to t('.wrap_activeadmin.media_items.upload'), '#',
                class: 'btn btn-primary btn-block dropzone-btn'
      end

      attributes_table_for resource do
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
