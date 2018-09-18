module Formtastic

  module Helpers

    # Overwriting ErrorsHelper - formtastic/lib/formtastic/helpers/errors_helper.rb
    module ErrorsHelper

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Rails/OutputSafety
      def semantic_errors(*args)
        html_options = args.extract_options!
        args -= [:base]
        full_errors =
          args.inject([]) do |array, method|
            array ||= []
            attribute =
              localized_string(method, method.to_sym, :label) ||
              humanized_attribute_name(method)
            errors = Array(@object.errors[method.to_sym].first).to_sentence
            errors.present? ? array << [attribute, errors].join(' ') : array
          end
        full_errors << @object.errors[:base]
        full_errors.flatten!
        full_errors.compact!
        return nil if full_errors.blank?
        html_options[:class] ||= 'errors mb-0 pl-3'
        template.content_tag :div, class: 'alert alert-danger' do
          template.content_tag(:ul, html_options) do
            full_errors.map { |error| template.content_tag(:li, error) }.join.html_safe
          end
        end
      end

    end

  end

end
