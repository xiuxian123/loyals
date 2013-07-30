# -*- encoding : utf-8 -*-
module LoyalAdmin
  class Display::Recipe < ActiveRecord::Base
    attr_accessible :url, :text, :title, :content, :open_style, :style

    validates_presence_of :url, :text

    self.table_name = 'loyal_admin_display_recipes'

    #
    # has method:
    #   - filter_named_open_style
    #
    self.loyal_core_acts_as_named_filter_able :open_style, :config => ::LoyalCore::ConfigUtil.new(
      { :value => 1, :desc => '新窗口打开',   :key => :_blank },
      { :value => 2, :desc => '当前窗口打开', :key => :_self }
    )

    def open_style_key
      self.filter_named_open_style.key
    end

    # 输出
    def generate_html style=:default
      html = ""

      html << <<-HTML
        <a href='#{self.url.to_s.html_safe}' target='#{self.open_style_key}' style='#{self.style.to_s.html_safe}' title='#{self.title.to_s.html_safe}'>#{self.text.to_s.html_safe}</a>
      HTML

      html
    end

  end
end
