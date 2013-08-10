# -*- encoding : utf-8 -*-
module LoyalSpider
  module Clients
    module KuaileMahua
      class ArticleEntity
        include ::LoyalSpider::EntityAble
        include ::LoyalSpider::FetchAble

        self.config_loyal_spider_default_fetch_options(
          :encoding_type => 'GBK',
          :base_url => 'http://www.kl688.com'
        )

        # TODO
        def after_fetch_success result
          # puts "after_fetch success: #{result}"
          html_doc = result.response_html_doc
          entity_doc = html_doc.css('.main .main-left .xiaohua .xiaohua-data')

          self.title = entity_doc.css('h1').first.text.to_s.strip
          self.content = entity_doc.css('.content').inner_html
          self.tags = entity_doc.css('.link .tags h4 a').map do |_tag_doc|
            {
              :text => _tag_doc.text.to_s.strip,
              :href => "#{self.base_url}#{_tag_doc.attr('href').to_s.strip}"
            }
          end

          self.tags_text = self.tags.map do |_tag|
            _tag[:text]
          end

          self.authors = entity_doc.css('.link .tags .pusher a').map do |_author_doc|
            {
              :text => _author_doc.text.to_s.strip,
              :href => "#{_author_doc.attr('href').to_s.strip}"
            }
          end

          self.up_rating      = entity_doc.css('.tools li a.good').text.to_i
          self.down_rating    = entity_doc.css('.tools li a.bad').text.to_i
          self.comments_count = entity_doc.css('.tools li s').first.text.to_i
debugger

        end

      end
    end
  end
end
