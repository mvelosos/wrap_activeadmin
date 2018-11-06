module ActiveAdmin

  module Views

    # Overwriting SiteTitle Component - activeadmin/lib/active_admin/views/components/site_title.rb
    class SiteTitle < Component

      def tag_name
        :div
      end

      def build(namespace)
        super(class: 'navbar')
        @namespace = namespace

        div class: 'navbar-brand' do
          site_title_content
        end
      end

      private

      def site_title_image
        div class: 'logo' do
          if site_title_image? && image_path
            title_image
          else
            div(title_text.split(' ').map(&:first)[0..1].join(''), class: 'placeholder')
          end
        end
      end

      def image_path
        helpers.render_or_call_method_or_proc_on(helpers, @namespace.site_title_image)
      end

      def close_link
        div title: I18n.t('active_admin.header_close') do
          a(class: 'btn btn-link d-xl-none',
            target: '_blank', 'data-toggle': 'collapse', 'data-target': '#header') do
            div(class: 'tooltip-holder', title: I18n.t('active_admin.header_close'),
                'data-toggle': 'tooltip', 'data-placement': 'bottom')
            i('', class: 'aa-icon aa-close-sidebar')
          end
        end
      end

      def site_title_link
        a(href: format_url,
          id: 'site-link', title: I18n.t('active_admin.view_site_link'),
          class: 'title-link', target: '_blank') do
          title_content
        end
      end

      def site_title
        div class: 'title-link' do
          title_content
        end
      end

      def title_content
        site_title_image
        div class: 'title-content text-truncate' do
          div title_text, class: 'title-text text-truncate'
        end
      end

      def site_title_content
        site_title_link? ? site_title_link : site_title
        close_link
      end

      def format_url(display: false)
        link = @namespace.site_title_link
        href = full_url_for(link).split('?').first
        href.chomp!('/') unless href.length <= 1
        return href unless display
        href = request.base_url if href.chomp('/').blank?
        href.sub(%r{^https?\:\/\/}, '')
      end

    end

  end

end
