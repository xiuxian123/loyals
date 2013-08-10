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

        def entity_clazz
          ::LoyalSpider::Clients::KuaileMahua::ArticleEntity
        end

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

            _title_link = entity_doc.css('h3 a').first

            _entity_attr[:title] = _title_link.text

            add_entity _entity_attr
          end
        end

        def after_fetch_fail result
          puts "after_fetch fail: #{result}"
        end

      end
    end
  end
end
