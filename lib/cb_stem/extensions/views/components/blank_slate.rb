module ActiveAdmin

  module Views

    # Build a Blank Slate
    class BlankSlate < ActiveAdmin::Component

      builder_method :blank_slate

      def default_class_name
        'blank_slate_container well'
      end

    end

  end

end
