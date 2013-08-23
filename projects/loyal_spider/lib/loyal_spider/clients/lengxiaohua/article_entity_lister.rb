# -*- encoding : utf-8 -*-
module LoyalSpider
  module Clients
    module Lengxiaohua
      class ArticleEntityLister
        include ::LoyalSpider::EntityListerAble

        self.config_loyal_spider_entity_lister :url_format_first => 'http://lengxiaohua.com/',
          :url_format => 'http://lengxiaohua.com/?page_num=%{page}',
          :entity_clazz => ::LoyalSpider::Clients::Lengxiaohua::ArticleEntity,
          :fetch_options => {
            :encoding_type => 'UTF-8',
            :base_url => 'http://lengxiaohua.com'
          }

        # TODO:
        def before_fetch options={}
          puts "before_fetch: #{options}"
        end

        # TODO
        def after_fetch_success result
          # puts "after_fetch success: #{result}"
          html_doc = result.response_html_doc

          html_doc.css('.joke_wrap li.joke_li').each do |entity_doc|
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

            _joke_id = entity_doc.css('.para_info .para_tool a').first.attr('jokeid')

            _entity_attr[:url] = "#{_base_url}/joke/#{_joke_id}"

            _entity_attr[:title] = ''

            _text_content = entity_doc.css('.para_can pre').first.inner_html

            _content = Sanitize.clean(_text_content).split(/\n/).map do |_cnt|
              "<p>#{_cnt}</p>"
            end.join('')

            if _img_box = entity_doc.css('.default_load_imgbox').first

              _image_content = _img_box.css('img').map do |_img|
                "<img src='#{_img.attr('data-original').to_s.gsub('!water', '')}'/>"
              end

              _content = _content + "<p>#{_image_content.join('')}</p>" if _image_content.any?
            end

            _entity_attr[:content] = _content

            _entity_attr[:tags] = entity_doc.css('.tag_box a').map do |_tag_doc|
              {
                :text => _tag_doc.text,
                :href => "#{self.base_url}#{_tag_doc.attr('href')}"
              }
            end

            # debugger

            _author_doc = entity_doc.css('.para_info .user_info a').first

            if _author_doc
              _entity_attr[:authors] = [
                {
                  :text => _author_doc.text.to_s.strip,
                  :href => "#{self.base_url}#{_author_doc.attr('href').to_s.strip}"
                }
              ]
            else
              _entity_attr[:authors] = []
            end

            _tool_doc = entity_doc.css('.para_tool')

            _entity_attr[:up_rating]      = _tool_doc.css('a[report=like_joke] span').last.text.gsub(/\W/, '').to_i
            _entity_attr[:down_rating]    = _tool_doc.css('a[report=unlike_joke] span').last.text.gsub(/\W/, '').to_i
            _entity_attr[:comments_count] = _tool_doc.css("#show_comment_count_#{_joke_id}").text.gsub(/\W/, '').to_i

            _entity = self.new_entity(_entity_attr)

            if _entity.valid?
              self.add_entity _entity
            end
          end

        end

        def after_fetch_fail result
          puts "after_fetch fail: #{result}"
        end

      end
    end
  end
end
