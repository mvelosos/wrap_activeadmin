# MenuHelpers
module CbStem::MenuHelpers

  def menu_label(label, icon: nil, badge: 0)
    safe_join [
      aa_icon(icon),
      menu_title(label),
      menu_badge(badge)
    ]
  end

  private

  def menu_title(label)
    content_tag(:span, label, class: 'menu-text')
  end

  def menu_badge(badge)
    return unless badge.is_a?(Integer) && badge.positive?
    badge = '99+' if badge > 99
    content_tag(:span, badge, class: 'badge badge-pill badge-primary')
  end

end
