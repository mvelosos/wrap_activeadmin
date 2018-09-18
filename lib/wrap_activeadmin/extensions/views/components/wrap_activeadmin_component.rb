module ActiveAdmin

  module Views

    # Custom Component - WrapActiveadminComponent
    class WrapActiveadminComponent < ActiveAdmin::Component

      builder_method :wrap_activeadmin_component

      def default_class_name
        'wrap-aa-component'
      end

      def build(name, *args)
        render("wrap_activeadmin/components/#{name}", *args)
      end

    end

  end

end
