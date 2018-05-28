module ActiveAdmin

  # Overwriting FormBuilder - activeadmin/lib/active_admin/form_builder.rb
  class FormBuilder < ::Formtastic::FormBuilder

    CANCEL_CLASS = 'btn btn-light'.freeze

    def cancel_link(url = { action: 'index' }, html_options = {}, li_attrs = {})
      li_attrs[:class]   ||= 'cancel list-inline-item'
      html_options[:class] = CANCEL_CLASS
      li_content = template.link_to I18n.t('active_admin.cancel'), url, html_options
      template.content_tag(:li, li_content, li_attrs)
    end

    # rubocop:disable all
    def has_many(assoc, options = {}, &block)
      HasManyBuilder.new(self, assoc, options).render(&block)
    end

    # Decorates a FormBuilder with the additional attributes and methods
    # to build a has_many block.  Nested has_many blocks are handled by
    # nested decorators.
    class HasManyBuilder < SimpleDelegator
      attr_reader :assoc
      attr_reader :options
      attr_reader :heading, :sortable_column, :sortable_start
      attr_reader :new_record, :destroy_option

      def initialize(has_many_form, assoc, options)
        super has_many_form
        @assoc = assoc
        @options = extract_custom_settings!(options.dup)
        @options.reverse_merge!(for: assoc)
        @options[:class] = [options[:class], "inputs has_many_fields list-unstyled"].compact.join(' ')

        if sortable_column
          @options[:for] = [assoc, sorted_children(sortable_column)]
        end
      end

      def render(&block)
        html = "".html_safe
        html << template.content_tag(:h5) { heading } if heading.present?
        html << template.capture { content_has_many(&block) }
        html = wrap_div_or_li(html)
        template.concat(html) if template.output_buffer
        html
      end

      protected

      # remove options that should not render as attributes
      def extract_custom_settings!(options)
        @heading         = options.key?(:heading) ? options.delete(:heading) : nil
        @sortable_column = options.delete(:sortable)
        @sortable_start  = options.delete(:sortable_start) || 1
        @new_record      = options.key?(:new_record) ? options.delete(:new_record) : true
        @destroy_option  = options.delete(:allow_destroy)
        options
      end

      def assoc_klass
        @assoc_klass ||= __getobj__.object.class.reflect_on_association(assoc).klass
      end

      def content_has_many(&block)
        form_block = proc do |form_builder|
          render_has_many_form(form_builder, options[:parent], &block)
        end

        template.assigns[:has_many_block] = true
        contents = without_wrapper { inputs(options, &form_block) }
        contents ||= "".html_safe

        js = new_record ? js_for_has_many(options[:class], &form_block) : ''
        contents << js
      end

      # Renders the Formtastic inputs then appends ActiveAdmin delete and sort actions.
      def render_has_many_form(form_builder, parent, &block)
        template.concat sortable_action(form_builder)
        template.concat form_fields(form_builder, parent, &block)
      end

      def form_fields(form_builder, parent, &block)
        index = parent && form_builder.send(:parent_child_index, parent)
        template.content_tag :li, class: 'has-many-fields' do
          template.concat(
            template.content_tag(:ol) do
              template.capture { yield(form_builder, index) }
            end
          )
          template.concat(form_actions(form_builder))
        end
      end

      def form_actions(form_builder)
        template.content_tag :ol, class: 'has-many-actions mt-3 form-group' do
          template.capture { has_many_actions(form_builder, "".html_safe) }
        end
      end

      def sortable_action(form_builder)
        if sortable_column
          form_builder.input sortable_column, as: :hidden

          template.content_tag(:li, class: 'form-group has-many-handle') do
            template.content_tag :div, class: 'handle' do
              template.render('cb_stem/svgs/sortable_handle.svg')
            end
            # template.link_to template.content_tag(:i, '', class: "nc-icon nc-move-05"), "#",
            #                  class: 'button btn text-secondary'
          end
        end
      end

      def has_many_actions(form_builder, contents)
        if allow_destroy?(form_builder.object)
          if form_builder.object.new_record?
            template.concat(
              template.content_tag(:li, class: 'form-group') do
                template.link_to I18n.t('active_admin.has_many_remove'), "#",
                                 class: 'button has_many_remove text-secondary'
              end
            )
          else
            form_builder.input(
              :_destroy, as: :boolean,
              wrapper_html: { class: 'has_many_delete' },
              label: I18n.t('active_admin.has_many_delete')
            )
          end
        end

        contents
      end

      def allow_destroy?(form_object)
        !! case destroy_option
           when Symbol, String
             form_object.public_send destroy_option
           when Proc
             destroy_option.call form_object
           else
             destroy_option
           end
      end

      def sorted_children(column)
        __getobj__.object.public_send(assoc).sort_by do |o|
          attribute = o.public_send column
          [attribute.nil? ? Float::INFINITY : attribute, o.id || Float::INFINITY]
        end
      end

      def without_wrapper
        is_being_wrapped = already_in_an_inputs_block
        self.already_in_an_inputs_block = false

        html = yield

        self.already_in_an_inputs_block = is_being_wrapped
        html
      end

      # Capture the ADD JS
      def js_for_has_many(class_string, &form_block)
        assoc_name       = assoc_klass.model_name
        placeholder      = "NEW_#{assoc_name.to_s.underscore.upcase.gsub(/\//, '_')}_RECORD"
        opts = {
          for: [assoc, assoc_klass.new],
          class: class_string,
          for_options: { child_index: placeholder }
        }
        html = template.capture{ __getobj__.send(:inputs_for_nested_attributes, opts, &form_block) }
        text = new_record.is_a?(String) ? new_record : I18n.t('active_admin.has_many_new', model: assoc_name.human)

        template.link_to '#', class: 'button has_many_add mt-3 btn btn-light', data: {
          html: CGI.escapeHTML(html).html_safe, placeholder: placeholder
        } do
          template.content_tag(:i, '', class: "nc-icon nc-simple-add mr-1") + text
        end
      end

      def wrap_div_or_li(html)
        opts = { class: "has_many_container #{assoc}" }
        if sortable_column
          opts.merge!(
            'data-sortable': sortable_column,
            'data-sortable-start': sortable_start
          )
        end
        template.content_tag(
          already_in_an_inputs_block ? :li : :div,
          html,
          opts
        )
      end
    end

  end

end
