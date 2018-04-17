module ActiveAdmin

  module HtmlContents

    # Register in ActiveAdmin::DSL - activeadmin/lib/active_admin/dsl.rb
    module DSL

      def html_content(name, options = {}, &block)
        config.html_contents << ActiveAdmin::HtmlContent.new(name, options, &block)
      end

    end

  end

end
