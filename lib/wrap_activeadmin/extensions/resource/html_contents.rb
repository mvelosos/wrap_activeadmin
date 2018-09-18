require 'active_admin/helpers/optional_display'

module ActiveAdmin

  class Resource

    # Register HtmlContents Resource
    module HtmlContents

      def html_contents
        @html_contents ||= []
      end

      def clear_html_contents!
        @html_contents = []
      end

      def html_contents_for(action, render_context = nil)
        html_contents.select do |section|
          section.display_on?(action, render_context)
        end.sort_by(&:priority)
      end

      def html_contents?
        @html_contents&.any?
      end

    end

  end

end
