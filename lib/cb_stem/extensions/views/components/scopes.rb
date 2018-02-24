require 'active_admin/helpers/collection'
require 'active_admin/view_helpers/method_or_proc_helper'

module ActiveAdmin

  module Views

    # Overwriting ActiveAdmin::Scope - activeadmin/lib/active_admin/views/components/scopes.rb
    class Scopes < ActiveAdmin::Component

      builder_method :scopes_renderer

      def build(scopes, options = {})
        scopes.each do |scope|
          build_scope(scope, options) if call_method_or_proc_on(self, scope.display_if_block)
        end
      end

      def default_class_name
        'scopes table_tools_segmented_control nav nav-tabs'
      end

      protected

      def build_scope(scope, options)
        li class: "#{classes_for_scope(scope)} nav-item" do
          a href: url_for(scope: scope.id, params: scope_params),
            class: 'table_tools_button nav-link' do
            text_node scope_name(scope)
            if should_render_scope?(scope, options)
              span get_scope_count(scope).to_s, class: 'badge badge-primary badge-pill'
            end
          end
        end
      end

      private

      def scope_name(scope)
        case scope.name
        when Proc then
          instance_exec(&scope.name).to_s
        else
          scope.name.to_s
        end
      end

      def scope_params
        request.query_parameters.except(
          :page,
          :scope,
          :commit,
          :format
        )
      end

      def should_render_scope?(scope, options)
        options[:scope_count] &&
          scope.show_count &&
          get_scope_count(scope).positive?
      end

    end

  end

end
