if CbStem.enable_media_library
  ActiveAdmin.register CbStem::MediaItem do
    decorate_with CbStem::Admin::MediaItemDecorator

    menu label: proc { menu_label(t('cb_stem.menu.media_items'), icon: 'folder-image') },
         priority: 1

    config.sort_order = 'position_asc'
    config.paginate   = false
    config.remove_action_item(:new)

    sortable

    actions :index, :show, :destroy

    permit_params :title

    # EXTRA HTML
    html_content :modals do
      modal id: 'folder-item-modal' do
      end
    end

    # ACTION ITEMS
    action_item :add_folder,
                only: :index do
      action_btn(
        t('.cb_stem.media_items.add'),
        [:new_folder, :admin, :cb_stem, :folder_items, parent_id: params[:parent_id]],
        remote: true,
        icon: 'simple-add',
        title: false
      )
    end

    # BREADCRUMBS
    breadcrumb do
      parent = CbStem::MediaItem.find_by id: params[:parent_id]
      if parent.present?
        links = [
          link_to(t('cb_stem.menu.media_items'), admin_cb_stem_media_items_path)
        ]
        links +=
          parent.ancestors.collect do |x|
            link_to(x.title, admin_cb_stem_media_items_path(parent_id: x))
          end
      end
      links
    end

    # CONTROLLER
    controller do
      def scoped_collection
        parent.present? ? parent.children : end_of_association_chain.roots
      end

      private

      def parent
        @parent ||= CbStem::FolderItem.find_by id: params[:parent_id]
      end
    end

    # INDEX
    filter :name
    filter :updated_at
    filter :created_at

    index title: proc { parent.present? ? parent.title : t('cb_stem.menu.media_items') } do
      sortable_handle_column
      selectable_column
      column :title, :identifier
      column :items_count
      actions(defaults: false) do |u|
        item t('active_admin.view'), [:admin, :cb_stem, :media_items, parent_id: u.id]
        item t('active_admin.edit'), [:edit_folder, :admin, :cb_stem, u.model], remote: true
        item t('active_admin.delete'), [:admin, :cb_stem, u.model],
             method: :delete,
             data: {
               confirm:  I18n.t('active_admin.delete_title'),
               message: I18n.t('active_admin.delete_confirmation')
             }
      end
    end

    # FORM
    form do |f|
      f.inputs do
        f.input :title
      end
      hr
      f.actions
    end
  end
end
