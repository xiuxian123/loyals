# -*- encoding : utf-8 -*-
module LoyalCore
  module FontSelectorHelper
    def loyal_core_helper_font_selector *args
      options = args.extract_options!

      selector = args.first || 'body'

      html = ''

      html << <<-HTML
        <span class='loyal-core-font-size-selector'>
          字体
          <input type='hidden' name='font-selector-size' value='#{selector.html_safe}'/>
          <a href='javascript:;' loyal-data-type-size='small'>小</a>
          <a href='javascript:;' loyal-data-type-size='medium'>中</a>
          <a href='javascript:;' loyal-data-type-size='large'>大</a>
        </span>
      HTML

      html.html_safe
    end
  end
end

