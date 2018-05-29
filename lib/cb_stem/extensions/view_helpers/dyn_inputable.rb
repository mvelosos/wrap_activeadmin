module ViewHelpers

  # ViewHelpers For DynInputable
  module DynInputable

    def dyn_select_collection(collection, config)
      collection.map do |x|
        arr = [dyn_display_name(x), x.id]
        if config['option_template']
          arr.push('data-template': dyn_option_template(x, config['option_template'],
                                                        config['option_decorator']))
        end
        arr
      end
    end

    def dyn_display_name(resource)
      resource.try(:display_name) ||
        resource.try(:title) ||
        resource.id
    end

    def dyn_option_template(resource, method, decorator)
      if decorator && Object.const_defined?(decorator)
        decorator.constantize.decorate(resource).try(method)
      else
        resource.try(method)
      end
    end

  end

end
