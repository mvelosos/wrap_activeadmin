if CbStem.enable_media_library
  ActiveAdmin.register CbStem::MediaItem do
    decorate_with CbStem::Admin::MediaItemDecorator

    menu label: proc { menu_label(t('cb_stem.menu.media_items'), icon: 'folder-image') },
         priority: 1

    config.sort_order = 'name_asc'
    config.paginate   = false
    config.remove_action_item(:new)

    actions :index, :show, :destroy

    permit_params :name

    # ACTIONS
    member_action :drop, method: :post do
      parent = CbStem::FolderItem.find_by(id: parent_id)
      item   = CbStem::MediaItem.find_by(id: params[:id])
      if parent && item
        item.update(parent: parent)
        flash[:notice] = t('.success', name: item.name, target: parent.name)
        head 200
      else
        flash[:error] = t('.error')
        message = render_to_string partial: 'cb_stem/components/flash', layout: false
        render json: message.to_json, status: :internal_server_error
        flash.discard
      end
    end

    # EXTRA HTML
    html_content :modals do
      modal id: 'folder-item-modal'
    end

    # ACTION ITEMS
    action_item :add_folder,
                only: :index do
      action_btn(
        t('.cb_stem.media_items.add'),
        [
          :new_folder, :admin, :cb_stem, :folder_items,
          parent_id: params[:parent_id]
        ],
        remote: true,
        icon: 'simple-add',
        title: false
      )
    end

    # BREADCRUMBS
    breadcrumb do
      parent = CbStem::MediaItem.find_by id: params[:parent_id]
      links  = []
      if params[:q].present?
        links += [
          link_to(t('cb_stem.menu.media_items'), admin_cb_stem_media_items_path)
        ]
      elsif parent.present?
        links += [
          link_to(t('cb_stem.menu.media_items'), admin_cb_stem_media_items_path)
        ]
        links +=
          parent.ancestors.collect do |x|
            link_to(x.name, admin_cb_stem_media_items_path(params[:parent_id]))
          end
      end
      links
    end

    # CONTROLLER
    controller do
      def scoped_collection
        if params[:q].present?
          params.delete :parent_id
          end_of_association_chain
        else
          parent.present? ? parent.children : end_of_association_chain.roots
        end
      end

      private

      def parent
        @parent ||= CbStem::FolderItem.find_by id: parent_id
      end

      def parent_id
        params[:parent_id]
      end

      def page_title
        if params[:q].present?
          t('cb_stem.menu.media_items/filtered')
        elsif parent.present?
          parent.name
        else
          t('cb_stem.menu.media_items')
        end
      end
    end

    # INDEX
    filter :name
    filter :updated_at
    filter :created_at

    index title: proc { page_title } do
      column '', class: 'col-handle' do |resource|
        div class: 'handle',
            'data-sort-url': url_for([:drop, :admin, :cb_stem, resource]) do
          handle_icon
        end
      end
      selectable_column
      column :name, :identifier, sortable: 'name'
      column :items_count
      column :updated_at
      actions(defaults: false) do |u|
        item t('active_admin.view'), [:admin, :cb_stem, :media_items, parent_id: params[:parent_id]]
        item t('active_admin.edit'), [:edit_folder, :admin, :cb_stem, u.model], remote: true
        item t('active_admin.delete'), [:admin, :cb_stem, u.model],
             method: :delete,
             data: {
               confirm:  I18n.t('active_admin.delete_title'),
               message: I18n.t('active_admin.delete_confirmation')
             }
      end
    end
  end
end
