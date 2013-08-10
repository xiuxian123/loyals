# -*- encoding : utf-8 -*-
module LoyalSpider
  module Clients
    module Xiaohuadi
      class ArticleEntityLister
        include ::LoyalSpider::EntityListerAble

        self.config_loyal_spider_entity_lister :url_format_first => 'http://www.xiaohuadi.com/%{category}/',
          :url_format => 'http://www.xiaohuadi.com/%{category}/index_%{page}.html',
          :entity_clazz => ::LoyalSpider::Clients::Xiaohuadi::ArticleEntity,
          :fetch_options => {
            :encoding_type => 'GBK',
            :base_url => 'http://www.xiaohuadi.com'
          }

        # TODO:
        def before_fetch options={}
          puts "before_fetch: #{options}"
        end

        # TODO
        def after_fetch_success result
          # puts "after_fetch success: #{result}"
          html_doc = result.response_html_doc

          html_doc.css('.ilistxllist>ul').each do |entity_doc|
            _entity_attr = {}

            _fetch_options = result.fetch_options
            _base_url      = _fetch_options.base_url.to_s.strip

            # :content         # 正文
            # :tags            # 标签
            # :tags_text       # 标签
            # :up_rating       # 好评数
            # :down_rating     # 差评数目
            # :comments_count  # 评论数目
            # :authors         # 抓取的作者信息

            _link_doc = entity_doc.css('.ilistxlctlB1 a')

            _entity_attr[:url] = "#{_base_url}#{_link_doc.attr('href')}"

            _entity_attr[:title] = "#{_link_doc.text}"

            _text_content = entity_doc.css('.ilistxlctlB2').first.inner_html

            _content = _text_content.split("<br>\r\n").map do |_cnt|
              "<p>#{Sanitize.clean _cnt}</p>"
            end.join('')

            _entity_attr[:content] = _content

            _category_doc = entity_doc.css('.ilistxlctlC table td a').last

            if _category_doc
              _entity_attr[:tags] = [
                {
                  :text => _category_doc.text,
                  :href => "#{self.base_url}#{_category_doc.attr('href')}"
                }
              ]
            else
              _entity_attr[:tags] = []
            end

            _entity_attr[:tags_text] = _entity_attr[:tags].map do |_tag|
              _tag[:text]
            end

            _entity_attr[:authors] = []

            _tool_doc = entity_doc.css('.ilistxlctlA ul li')

            _entity_attr[:up_rating]      = _tool_doc[1].text.to_i
            _entity_attr[:down_rating]    = _tool_doc[2].text.to_i
            _entity_attr[:comments_count] = _tool_doc[0].text.to_i

            _entity = self.new_entity(_entity_attr)

            if _entity.content.include?('未显示完，查看全文')
              _entity.fetch
            end

            if _entity.valid?
              self.add_entity _entity
            end
          end

debugger
        end

        def after_fetch_fail result
          puts "after_fetch fail: #{result}"
        end

      end
    end
  end
end
