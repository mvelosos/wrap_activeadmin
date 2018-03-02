module Formtastic

  module Inputs

    # Overwriting Formastic Default FileInput - formtastic/lib/formtastic/inputs/file_input.rb
    class FileInput

      include Base

      def to_html
        input_wrapping do
          label_html << file_input
        end
      end

      def file_input
        template.content_tag(:div, class: file_input_class) do
          attachment_preview + file_placeholder + file_button
        end
      end

      # rubocop:disable Metrics/AbcSize
      def attachment_preview
        template.content_tag :div, class: 'file-preview mr-2' do
          object.try(method).present? && object.try(method).image? &&
            template.image_tag(object.try(method)&.url)
        end
      end

      def file_input_class
        klass = %w[form-control form-control-file]
        klass << 'active' if attachment.present?
        klass.join(' ')
      end

      private

      def attachment
        object.try("#{method}_identifier")
      end

      def file_placeholder
        template.content_tag(:div, attachment, class: 'file-text mr-2') <<
          template.content_tag(
            :div, ::I18n.t('cb_stem.form.placeholders.choose_file'),
            class: 'file-placeholder text-muted'
          )
      end

      def file_button
        template.content_tag(
          :label, label_text, class: 'file-input btn btn-sm btn-light mb-0'
        ) do
          template.content_tag(:span, ::I18n.t('cb_stem.form.choose_file')) <<
            builder.file_field(method, input_html_options)
        end
      end

    end

  end

end
