module ActiveAdmin

  module Comments

    module Views

      # Overwriting ActiveAdmin Comments -
      # activeadmin/lib/active_admin/orm/active_record/comments/views/active_admin_comments.rb
      # rubocop:disable Metrics/ClassLength
      class Comments < ActiveAdmin::Views::Panel

        protected

        def build_comments
          build_comment_form
          div class: 'comment-list' do
            if @comments.any?
              @comments.reverse.
                each(&method(:build_comment))
            else
              build_empty_message
            end
          end
        end

        def build_comment(comment)
          div for: comment, class: 'media comment-item' do
            div class: 'media-image' do
              comment_avatar(comment)
            end
            div class: 'media-body' do
              comment_body(comment)
            end
          end
        end

        # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        def build_comment_form
          active_admin_form_for(
            ActiveAdmin::Comment.new,
            url: comment_form_url,
            html: { class: 'admin-comment-form' }
          ) do |f|
            f.inputs do
              f.input :resource_type,
                      as: :hidden,
                      input_html: { value: ActiveAdmin::Comment.resource_type(parent.resource) }
              f.input :resource_id,
                      as: :hidden,
                      input_html: { value: parent.resource.id }
              f.input :body,
                      label: false,
                      input_html: { rows: '4', placeholder: 'Your comments...' }
            end
            f.actions do
              f.action :submit, label: I18n.t('active_admin.comments.add')
            end
          end
        end

        private

        def empty_state_msg
          blank_slate_msg(
            new_resource_path: nil,
            resource_name: ActiveAdmin::Comment.model_name.human(count: 2)
          )
        end

        def comment_body(comment)
          div class: 'comment-body' do
            comment_meta(comment)
            div class: 'mt-2' do
              comment.body&.html_safe
            end
          end
        end

        def comment_meta(comment)
          div class: 'd-flex flex-row' do
            div class: 'col pl-0' do
              comment_author(comment)
              comment_date(comment)
            end
            div class: 'col-auto pr-0' do
              comment_actions(comment)
            end
          end
        end

        def comment_avatar(comment)
          thumbnail(comment.author&.avatar, class: 'mr-2', icon: 'single-02')
        end

        def comment_author(comment)
          h6 class: 'mb-0' do
            if comment.author
              auto_link(comment.author)
            else
              I18n.t('active_admin.comments.author_missing')
            end
          end
        end

        def comment_date(comment)
          div class: 'text-muted' do
            small pretty_format comment.created_at
          end
        end

        def comment_actions(comment)
          div class: 'comment-actions' do
            dropdown_menu '', icon: 'menu-dots',
                              button: { class: 'p-0' },
                              menu: { class: 'dropdown-menu-right' } do
              if authorized?(ActiveAdmin::Auth::DESTROY, comment)
                comment_action_delete(comment)
              end
            end
          end
        end

        def comment_action_delete(comment)
          item(
            I18n.t('active_admin.comments.delete'), comments_url(comment.id),
            method: :delete, class: 'comment-delete',
            data: { confirm: I18n.t('active_admin.comments.delete_confirmation') }
          )
        end

      end

    end

  end

end
