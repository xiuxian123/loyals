# -*- encoding : utf-8 -*-
module LoyalSpider
  module Clients
    module KuaileMahua
      class ArticleEntityLister
        include ::LoyalSpider::FetchAble
        include ::LoyalSpider::EntityListerAble

        self.config_loyal_spider_default_fetch_options :encoding_type => 'GBK'

        self.config_loyal_spider_entity_lister :url_format_first => 'http://www.kl688.com/',
          :url_format => 'http://www.kl688.com/newjokes/index_%{page}.htm'

        # TODO:
        def before_fetch options={}
          puts "before_fetch: #{options}"
        end

        # TODO
        def after_fetch_success result
          puts "after_fetch success: #{result}"
        end

        def after_fetch_fail result
          puts "after_fetch fail: #{result}"
        end

      end
    end
  end
end
