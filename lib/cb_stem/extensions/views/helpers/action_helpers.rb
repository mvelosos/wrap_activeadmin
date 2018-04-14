# ActionHelpers
module CbStem::ActionHelpers

  def action_btn(title, url, html_options = {})
    icon          = html_options.delete(:icon)  { nil }
    display_title = html_options.delete(:title) { false }
    html_options[:class] ||= 'btn-link'
    html_options[:class]   = "btn #{html_options[:class]}".strip.squeeze
    options = html_options.merge(title: title, data: { toggle: 'tooltip', placement: 'bottom' })
    link_to url, options do
      concat content_tag(:i, '', class: "nc-icon nc-#{icon}") if icon
      concat content_tag(:span, title, class: 'action-text')  if display_title
    end
  end

end
