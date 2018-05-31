module ActiveAdmin

  # Register ActiveAdmin Extension HtmlContent
  class HtmlContent

    include ActiveAdmin::OptionalDisplay

    attr_accessor :name, :options, :block

    def initialize(name, options = {}, &block)
      @name    = name.to_s
      @options = options
      @block   = block
      normalize_display_options!
    end

    # The id gets used for the div in the view
    def id
      "#{name.downcase.underscore}_html_content".parameterize
    end

    # If a block is not passed in, the name of the partial to render
    def partial_name
      options[:partial] || "#{name.downcase.tr(' ', '_')}_html_content"
    end

    def custom_class
      options[:class]
    end

    def priority
      options[:priority] || 10
    end

  end

end
