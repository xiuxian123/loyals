# -*- encoding : utf-8 -*-
module LoyalSpider
  module Clients
    module KuaileMahua
      class ArticleEntityLister
        include ::LoyalSpider::EntityListerAble

        self.config_loyal_spider_entity_lister :url_format_first => 'http://www.kl688.com/',
          :url_format => 'http://www.kl688.com/newjokes/index_%{page}.htm',
          :entity_clazz => ::LoyalSpider::Clients::KuaileMahua::ArticleEntity,
          :fetch_options => {
            :encoding_type => 'GBK',
            :base_url => 'http://www.kl688.com'
          }

        # TODO:
        def before_fetch options={}
          puts "before_fetch: #{options}"
        end

        # TODO
        def after_fetch_success result
          # puts "after_fetch success: #{result}"
          html_doc = result.response_html_doc

          html_doc.css('.main .main-left .xiaohua').each do |entity_doc|
            _entity_attr = {}

            _fetch_options = result.fetch_options
            _base_url      = _fetch_options.base_url.to_s.strip

            _title_link = entity_doc.css('h3 a').first

            # :content         # 正文
            # :tags            # 标签
            # :tags_text       # 标签
            # :up_rating       # 好评数
            # :down_rating     # 差评数目
            # :comments_count  # 评论数目
            # :authors         # 抓取的作者信息

            _entity_attr[:url]   = "#{_base_url}#{_title_link.attr('href').to_s.strip}"

            _entity_attr[:title] = _title_link.text
            _entity_attr[:content] = entity_doc.css('.content').inner_html
            _entity_attr[:tags] = entity_doc.css('.link .tags h4 a').map do |_tag_doc|
              {
                :text => _tag_doc.text.to_s.strip,
                :href => "#{_base_url}#{_tag_doc.attr('href').to_s.strip}"
              }
            end

            _entity_attr[:authors] = entity_doc.css('.link .tags .pusher a').map do |_author_doc|
              {
                :text => _author_doc.text.to_s.strip,
                :href => "#{_author_doc.attr('href').to_s.strip}"
              }
            end

            _entity_attr[:up_rating]      = entity_doc.css('.tools li a.good').text.to_i
            _entity_attr[:down_rating]    = entity_doc.css('.tools li a.bad').text.to_i
            _entity_attr[:comments_count] = entity_doc.css('.tools li s').first.text.to_i

            _entity = self.new_entity(_entity_attr)

            if entity_doc.css('.content .more a').any?
              _entity.fetch
            end

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
