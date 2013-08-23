# -*- encoding : utf-8 -*-

module MustacheRender::ActionView
  class TemplateHandler
    def self.call(template)
      "#{name}.new(self).render(template, local_assigns)"
    end

    def initialize(view = nil)
      @view = view
    end

    def render(template, local_assigns={})
      if local_assigns.key?(:mustache)
        MustacheRender::Mustache.render(template.source.to_s, local_assigns[:mustache])
      else
        template.source.to_s
      end
    end
  end
end

if defined?(::ActionView::Template)
  ::ActionView::Template.register_template_handler(:mustache, MustacheRender::ActionView::TemplateHandler)
end
