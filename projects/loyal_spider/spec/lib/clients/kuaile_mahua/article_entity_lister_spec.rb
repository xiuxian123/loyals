# -*- encoding : utf-8 -*-
require 'spec_helper'

module LoyalSpider
  module Clients
    module KuaileMahua
      describe :ArticleEntityLister do
        it 'is class' do
          LoyalSpider::Clients::KuaileMahua::ArticleEntityLister.is_a?(Class)
        end

        let :the_clazz do
          LoyalSpider::Clients::KuaileMahua::ArticleEntityLister
        end

        context '基本抓取测试' do
          it 'init ok' do
            the_clazz.new.is_a?(the_clazz)
          end

          it 'fetch' do
            entity = the_clazz.new

            result = entity.fetch

puts result.response
          end
        end
      end
    end
  end
end
