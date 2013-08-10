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

      end
    end
  end
end
