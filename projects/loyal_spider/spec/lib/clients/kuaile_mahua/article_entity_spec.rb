# -*- encoding : utf-8 -*-
require 'spec_helper'

module LoyalSpider
  module Clients
    module KuaileMahua
      describe :ArticleEntity do
        it 'is class' do
          LoyalSpider::Clients::KuaileMahua::ArticleEntity.is_a?(Class)
        end

        let :the_clazz do
          LoyalSpider::Clients::KuaileMahua::ArticleEntity
        end

        context '基本抓取测试' do
          it 'init ok' do
            the_clazz.new.is_a?(the_clazz)
          end

        end
      end
    end
  end
end
