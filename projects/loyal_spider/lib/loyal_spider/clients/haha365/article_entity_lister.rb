# -*- encoding : utf-8 -*-
module LoyalSpider
  module Clients
    module Haha365
      class ArticleEntityLister
        include ::LoyalSpider::EntityListerAble

        self.config_loyal_spider_entity_lister :url_format_first => 'http://www.haha365.com/%{category}/',
          :url_format => 'http://www.haha365.com/%{category}/index_%{page}.htm',
          :entity_clazz => ::LoyalSpider::Clients::Haha365::ArticleEntity,
          :fetch_options => {
            :encoding_type => 'GBK',
            :base_url => 'http://www.haha365.com'
          }

        # TODO:
        def before_fetch options={}
          puts "before_fetch: #{options}"
        end

        # TODO
        def after_fetch_success result
          # puts "after_fetch success: #{result}"
          html_doc = result.response_html_doc

          # _basic_doc = html_doc.css('html #main .content .left .r_c .cat_llb')
          _basic_doc = html_doc.css('html #main .content .left .r_c')

            # :content         # 正文
            # :tags            # 标签
            # :up_rating       # 好评数
            # :down_rating     # 差评数目
            # :comments_count  # 评论数目
            # :authors         # 抓取的作者信息

          (0...(_basic_doc.css('.cat_llb .fl a').size)).each do |_index|

            _title_doc    = _basic_doc.css('.cat_llb h3 a')[_index]
            _content_doc  = _basic_doc.css('.cat_llb #endtext')[_index]
            _category_doc = _basic_doc.css('.cat_llb .fl a')[_index]

            if _title_doc.nil? || _content_doc.nil? || _category_doc.nil?
              next
            end

            _entity_attr = {}

            _text_content = _content_doc.try :inner_html

            _content = _text_content.to_s.split("<br>\r\n").map do |_cnt|
              "<p>#{(Sanitize.clean _cnt).to_s.strip}</p>"
            end.join('')

            _entity_attr[:content] = _content

            _entity_attr[:url] = "#{self.base_url}#{_title_doc.attr('href')}"
            _entity_attr[:title] = "#{_title_doc.text}"

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

            _entity_attr[:authors] = []

            _entity_attr[:up_rating]      = -1
            _entity_attr[:down_rating]    = -1
            _entity_attr[:comments_count] = -1

            _entity = self.new_entity(_entity_attr)

            if _entity.valid?
              self.add_entity _entity
            end
          end

          # debugger
        end

        def after_fetch_fail result
          puts "after_fetch fail: #{result}"
        end

      end
    end
  end
end
