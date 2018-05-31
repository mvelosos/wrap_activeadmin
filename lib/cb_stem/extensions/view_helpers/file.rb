module ViewHelpers

  # ViewHelpers For Display
  module File

    def file_link(object, name: 'file')
      return unless file_link?(object, name)
      file_preview_label + file_preview_link(object, name)
    end

    private

    def file_link?(object, name)
      object.respond_to?(name.to_sym) &&
        object.send(name.to_sym).present?
    end

    def file_preview_label
      content_tag(:span, I18n.t('cb_stem.file_preview.label'))
    end

    def file_preview_link(object, name)
      link_to object.send("#{name}_identifier".to_sym),
              object.send(name.to_sym).url,
              target: '_blank'
    end

  end

end
