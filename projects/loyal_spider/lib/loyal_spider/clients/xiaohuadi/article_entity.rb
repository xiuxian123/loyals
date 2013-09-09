# -*- encoding : utf-8 -*-
module LoyalSpider
  module Clients
    module Xiaohuadi
      class ArticleEntity
        include ::LoyalSpider::EntityAble
        include ::LoyalSpider::FetchAble

        self.config_loyal_spider_default_fetch_options(
          :encoding_type => 'GBK',
          :base_url => 'http://www.xiaohuadi.com'
        )

        # TODO
        def after_fetch_success result
          # puts "after_fetch success: #{result}"
          entity_doc = result.response_html_doc.css('.listx')

          _fetch_options = self.fetch_options
          _base_url      = _fetch_options.base_url.to_s.strip

          # :content         # 正文
          # :tags            # 标签
          # :up_rating       # 好评数
          # :down_rating     # 差评数目
          # :comments_count  # 评论数目
          # :authors         # 抓取的作者信息

          _text_doc = entity_doc.css('.sonxltitle h1')

          self.title = "#{_text_doc.text}"

          _text_content = entity_doc.css('.sonxlarticle').first.inner_html

          _content = _text_content.split("<br>\r\n").map do |_cnt|
            "<p>#{Sanitize.clean _cnt}</p>"
          end.join('')

          self.content = _content

          _category_doc = entity_doc.css('.sonxlPosition a').last

          if _category_doc
            self.tags = [
              {
                :text => _category_doc.text,
                :href => "#{self.base_url}#{_category_doc.attr('href')}"
              }
            ]
          else
            self.tags = []
          end

          self.authors = []

          self.up_rating      = -1
          self.down_rating    = -1
          self.comments_count = -1

        end

      end
    end
  end
end
