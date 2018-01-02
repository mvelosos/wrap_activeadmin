module ActiveAdmin

  module Views

    # Overwriting SiteTitle Component - activeadmin/lib/active_admin/views/components/site_title.rb
    class SiteTitle < Component

      def tag_name
        :div
      end

      def build(namespace)
        super(id: 'site-title', class: 'navbar-header')
        @namespace = namespace

        div class: 'navbar-brand' do
          if site_title_link?
            text_node site_title_with_link
          else
            text_node site_title_content
          end
        end
      end

    end

  end

end
