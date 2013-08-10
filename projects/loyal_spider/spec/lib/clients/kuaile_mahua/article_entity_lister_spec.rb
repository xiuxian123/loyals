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

          # it 'paged fetch' do
          #   entity = the_clazz.new

          #   result = entity.paged_fetch 2
          #   result.fetch_options.url.should == 'http://www.kl688.com/newjokes/index_2.htm'
          # end

          it 'class paged fetch' do
            result = the_clazz.paged_fetch 2

debugger

            result.fetch_options.url.should == 'http://www.kl688.com/newjokes/index_2.htm'
          end


          # it 'fetch' do
          #   entity = the_clazz.new

          #   result = entity.fetch
          # end

          # it 'class fetch' do
          #   result = the_clazz.fetch
          # end

        end
      end
    end
  end
end
