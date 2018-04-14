# Extend ActiveAdmin ViewHelpers
module ActiveAdmin::ViewHelpers

  Dir[File.expand_path('views/helpers', __dir__) + '/*.rb'].each { |f| require f }

  include CbStem::MenuHelpers
  include CbStem::FormatHelpers
  include CbStem::ActionHelpers
  include CbStem::IdentifierHelpers
  include CbStem::MediaHelpers
  include CbStem::FlashHelpers

  alias batch_form active_admin_form_for

end
