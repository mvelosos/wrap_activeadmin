if WrapActiveadmin.enable_media_library
  ActiveAdmin.register WrapActiveadmin::MediaItem do
    decorate_with WrapActiveadmin::Admin::MediaItemDecorator

    menu label: proc { menu_label(t('wrap_activeadmin.menu.media_items'), icon: 'folder-image') },
         priority: 1

    config.sort_order = 'file_type_desc'
    config.paginate   = false
    config.remove_action_item(:new)

    actions :index

    permit_params :name

    # BATCH ACTIONS
    # rubocop:disable Metrics/LineLength
    batch_action :move, confirm: proc { t('.wrap_activeadmin.media_items.add_to_folder') }, priority: 1, batch_form: proc {
      batch_form :media_item do |f|
        f.inputs do
          f.input :parent_id,
                  label: false,
                  as: :select,
                  collection: (
                    WrapActiveadmin::Admin::MediaItemDecorator.decorate_collection(
                      WrapActiveadmin::FolderItem.order(name: :asc)
                    ).map { |u| [u.name, u.id, { 'data-template': u.select_item_template }] }
                  ),
                  input_html: {
                    class: 'select2',
                    data: {
                      'select2-search': true,
                      'select2-clear': true,
                      'select2-template': true,
                      'select2-selection-template': true,
                      'select2-placeholder': t('wrap_activeadmin.components.select2.placeholder')
                    }
                  }
        end
      end
    } do |ids, inputs|
      media_items = WrapActiveadmin::MediaItem.where(id: ids)
      parent      = WrapActiveadmin::FolderItem.find_by(id: inputs['media_item[parent_id]'])
      count       = media_items.length
      if media_items && parent
        media_items.find_each { |x| x.update(parent: parent) unless parent.id == x.id }
        flash[:notice] =
          t('active_admin.batch_actions.media_items.success',
            items: "#{count} #{WrapActiveadmin::MediaItem.model_name.human(count: count).downcase}",
            value: parent.name)
      else
        flash[:error] =
          t('active_admin.batch_actions.media_items.failure',
            value: WrapActiveadmin::MediaItem.model_name.human)
      end
      redirect_back fallback_location: %i[admin wrap_activeadmin media_items]
    end
    # rubocop:enable Metrics/LineLength

    # ACTIONS
    batch_action :delete,
                 confirm: I18n.t('active_admin.delete_title'),
                 message: I18n.t('active_admin.delete_confirmation') do |ids|
      WrapActiveadmin::MediaItem.where(id: ids).destroy_all
      redirect_back fallback_location: %i[admin wrap_activeadmin media_items]
    end

    member_action :drop, method: :post do
      parent = WrapActiveadmin::FolderItem.find_by(id: parent_id)
      item   = WrapActiveadmin::MediaItem.find_by(id: params[:id])
      if parent && item
        item.update(parent: parent)
        flash[:notice] = t('.success', name: item.name, target: parent.name)
        head 200
      else
        flash[:error] = t('.error')
        message = render_to_string partial: 'wrap_activeadmin/components/flash', layout: false
        render json: message.to_json, status: :internal_server_error
        flash.discard
      end
    end

    # EXTRA HTML
    html_content :modals do
      modal id: 'folder-item-modal'
    end

    # ACTION ITEMS
    action_item :add_file,
                only: :index do
      action_btn(
        t('.wrap_activeadmin.media_items.add_file'),
        '#',
        icon: 'simple-add',
        title: false,
        class: 'dropzone-btn btn-link'
      )
    end

    action_item :add_folder,
                only: :index do
      action_btn(
        t('.wrap_activeadmin.media_items.add_folder'),
        [
          :new_folder, :admin, :wrap_activeadmin, :folder_items,
          parent_id: params[:parent_id]
        ],
        remote: true,
        icon: 'folder-add',
        title: false
      )
    end

    # BREADCRUMBS
    breadcrumb do
      parent = WrapActiveadmin::MediaItem.find_by id: params[:parent_id]
      links  = []
      if params[:q].present?
        links += [
          link_to(t('wrap_activeadmin.menu.media_items'), admin_wrap_activeadmin_media_items_path)
        ]
      elsif parent.present?
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
        @parent ||= WrapActiveadmin::FolderItem.find_by id: parent_id
      end

      def parent_id
        params[:parent_id]
      end

      def page_title
        if params[:q].present?
          t('wrap_activeadmin.menu.media_items/filtered')
        elsif parent.present?
          parent.name
        else
          t('wrap_activeadmin.menu.media_items')
        end
      end
    end

    # INDEX
    html_content :dropzone, only: :index do
      render 'media_items_upload'
    end

    filter :name
    filter :reference_key
    filter :file_type
    filter :updated_at
    filter :created_at

    index title: proc { page_title } do
      selectable_column
      column :name, :identifier, sortable: 'name'
      column :file_type
      column :file_size
      column :reference_key
      column :updated_at
      actions(defaults: false) do |u|
        if u.type == 'WrapActiveadmin::FolderItem'
          item t('active_admin.view'),
               [:admin, :wrap_activeadmin, :media_items, parent_id: params[:parent_id]]
          item t('active_admin.edit'),
               [:edit_folder, :admin, :wrap_activeadmin, u.model], remote: true
        else
          item t('active_admin.view'),
               admin_wrap_activeadmin_file_item_path(u, parent_id: u)
        end
        item t('active_admin.delete'), [:admin, :wrap_activeadmin, u.model],
             method: :delete,
             data: {
               confirm:  I18n.t('active_admin.delete_title'),
               message: I18n.t('active_admin.delete_confirmation')
             }
      end
    end
  end
end
