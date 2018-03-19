module ActiveAdmin

  # BaseController for ActiveAdmin.
  # It implements ActiveAdmin controllers core features.
  # Overwriting BaseController - activeadmin/lib/active_admin/base_controller.rb
  class BaseController < ::InheritedResources::Base

    def update
      update! do |success, _failure|
        success.html { redirect_to [:edit, :admin, resource] }
      end
    end

  end

end
