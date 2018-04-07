module ActiveAdmin

  # Overwriting SidebarSection - activeadmin/lib/active_admin/sidebar_section.rb
  class SidebarSection

    def initialize(name = nil, options = {}, &block)
      @name    = name.to_s
      @options = options
      @block   = block
      normalize_display_options!
    end

    # The title gets displayed within the section in the view
    def title
      return if name.blank?
      I18n.t("active_admin.sidebars.#{name}", default: name.titlecase)
    end

  end

end
