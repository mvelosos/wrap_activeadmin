# Extend ActiveAdmin ViewHelpers
module ActiveAdmin::ViewHelpers

  include ViewHelpers::Base
  include ViewHelpers::BlankSlate
  include ViewHelpers::Sortable
  include ViewHelpers::Notice
  include ViewHelpers::Display
  include ViewHelpers::File
  include ViewHelpers::Tab
  include ViewHelpers::Component
  include ViewHelpers::Menu
  include ViewHelpers::DynInputable
  include ViewHelpers::Country

  alias batch_form active_admin_form_for

end
