module ViewHelpers

  # ViewHelpers For Menu
  module Menu

    def menu_label(label, *args)
      options = args.extract_options!
      icon    = options.delete(:icon) { nil }
      badge   = options.delete(:badge) { 0 }
      safe_join [
        aa_icon(icon, options),
        menu_title(label),
        menu_badge(badge)
      ]
    end

    private

    def menu_title(label)
      title = label.is_a?(Class) ? label.model_name.human(count: 2) : label
      content_tag(:span, title, class: 'menu-text')
    end

    def menu_badge(badge)
      return unless badge.is_a?(Integer) && badge.positive?
      badge = '99+' if badge > 99
      content_tag(:span, badge, class: 'badge badge-pill badge-primary')
    end

  end

end
