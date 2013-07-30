# -*- encoding : utf-8 -*-
module LoyalCore::ActionView
  class LabeledBuilder < ::ActionView::Helpers::FormBuilder
    # 选择编辑器的类型
    def select_editor_content_mode name, *args
      (field_label name, *args) + @template.tag(:br) + self.select(
        name,
        object.class.send(:"content_mode_config").to_select_options,
        {},
        {
          :class => 'loyal-editor-content-mode-selector'
        }
      )
    end

    %w[kindeditor url_field text_field text_area password_field collection_select].each do |method_name|
      define_method method_name do |name, *args|
        @template.content_tag :div, class: "field" do
          (field_label name, *args) + @template.tag(:br) + super(name, *args)
        end
      end
    end

    def select_with_label name, *args
      @template.content_tag :div, class: "field" do
        (field_label name, *args) + @template.tag(:br) + self.select(name, *args)
      end
    end

    def filter_named_select name, *args
      (field_label name, *args) + @template.tag(:br) + select(
        name, object.class.send(:"#{name}_named_filter_config").to_select_options
      )
    end

    def bit_able_check_box name, *args
      result = (field_label name, *args) + @template.tag(:br)

      config = object.class.send(:"#{name}_bit_config")

      config.keys.each do |_name|
        _config = config[_name]

        if _config.value > 0
          _checkbox_options = {
            :type => :checkbox,
            :value => _config.key,
            :name => "#{name}_values[]"
          }

          if object.send(:"#{name}_bit?", _name)
            _checkbox_options[:checked] = :checked
          end

          result << (
            @template.tag :input, _checkbox_options
          )

          result << "#{_config.desc}"
        end
      end

      result
    end

    def submit value=nil, options={}
      @template.submit_tag (value || I18n.t('loyal_core.action_view.form_builder.submit.default_value')),
        options.reverse_merge(
          :data => {
            :disable_with => I18n.t('loyal_core.action_view.form_builder.submit.disable_with')
          }
      )
    end

    # def check_box(name, *args)
    #   @template.content_tag :div, class: 'field' do
    #     super + ' ' + field_label(name, *args)
    #   end
    # end

    def nested_parent_select name, class_or_item, *args
      impl_nested_belongs_to_select_with_mover name, object, class_or_item, object.class, *args

      # @template.content_tag :div, class: "field" do
      #   (field_label name, *args) + @template.tag(:br) + select(
      #     name, *([object.class.nested_set_select_options(nil, object, :include_blank => true)] + args) 
      #   )
      # end
    end

    def nested_belongs_to_select name, clazz, class_or_item, *args
      impl_nested_belongs_to_select_with_mover name, nil, class_or_item, clazz, *args
    end

    def error_messages
      if object.errors.full_messages.any?
        @template.content_tag(:div, :class => 'error_messages') do
          @template.content_tag :h2, (
            "#{@template.pluralize(object.errors.count, "error")} #{I18n.t('views.form.prohibited_being_saved')}:"
          )

          @template.content_tag :ul do
            object.errors.full_messages.map do |msg|
              @template.content_tag :li, msg
            end.join.html_safe
          end
        end
      end
    end

    private

    def impl_nested_belongs_to_select_with_mover name, mover, class_or_item, clazz, *args
      @template.content_tag :div, class: "field" do
        (field_label name, *args) + @template.tag(:br) + select(
          name, *([clazz.nested_set_select_options(class_or_item, mover, :include_blank => true)] + args) 
        )
      end
    end

    def field_label(name, *args)
      options = args.extract_options!
      label(name, options[:label])
    end

  end
end
