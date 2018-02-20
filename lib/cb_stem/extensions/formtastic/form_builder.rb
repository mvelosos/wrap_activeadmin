module Formtastic

  # Overwriting - FormBuilder
  # rubocop:disable Metrics/LineLength
  class FormBuilder < ActionView::Helpers::FormBuilder

    # configure :custom_namespace
    # configure :default_text_field_size
    # configure :default_text_area_height, 20
    # configure :default_text_area_width
    # configure :all_fields_required_by_default, true
    # configure :include_blank_for_select_by_default, true
    # configure :required_string, proc { %{<abbr title="#{Formtastic::I18n.t(:required)}">*</abbr>}.html_safe }
    # configure :optional_string, ''
    # configure :inline_errors, :sentence
    # configure :label_str_method, :humanize
    # configure :collection_label_methods, %w[to_label display_name full_name name title username login value to_s]
    # configure :collection_value_methods, %w[id to_s]
    # configure :file_methods, [ :file?, :public_filename, :filename ]
    # configure :file_metadata_suffixes, ['content_type', 'file_name', 'file_size']
    # configure :priority_countries, ["Australia", "Canada", "United Kingdom", "United States"]
    # configure :i18n_lookups_by_default, true
    # configure :i18n_cache_lookups, true
    # configure :i18n_localizer, Formtastic::Localizer
    # configure :escape_html_entities_in_hints_and_labels, true
    # configure :default_commit_button_accesskey
    configure :default_inline_error_class, 'form-text text-danger'
    configure :default_error_list_class, 'errors'
    configure :default_hint_class, 'form-text text-muted'
    configure :use_required_attribute, false
    configure :perform_browser_validations, false
    # Check {Formtastic::InputClassFinder} to see how are inputs resolved.
    configure :input_namespaces, [::Object, ::Formtastic::Inputs]
    configure :input_class_finder, Formtastic::InputClassFinder
    # Check {Formtastic::ActionClassFinder} to see how are inputs resolved.
    configure :action_namespaces, [::Object, ::Formtastic::Actions]
    configure :action_class_finder, Formtastic::ActionClassFinder

    configure :skipped_columns, %i[created_at updated_at created_on updated_on lock_version version]
    configure :priority_time_zones, []

    attr_reader :template

    attr_reader :auto_index

  end

end
