module ActiveAdmin

  module Views

    # Custom Component - CbStemComponent
    class CbStemComponent < ActiveAdmin::Component

      builder_method :cb_stem_component

      def default_class_name
        'cb-stem-component'
      end

      def build(name, *args)
        render("cb_stem/components/#{name}", *args)
      end

    end

  end

end
