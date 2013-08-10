# -*- encoding : utf-8 -*-
module LoyalSpider
  module FetchAble
    # 有返回信息的
    def self.included base
      base.class_eval do
        attr_accessor :fetch_options

        include InstanceMethods
        extend  ClassMethods
      end
    end

    module ClassMethods
      # 配置蜘蛛的抓取配置
      def config_loyal_spider_default_fetch_options options={}
        @default_fetch_options ||= options
      end

      def default_fetch_options
        @default_fetch_options ||= {}
      end

    end

    module InstanceMethods
      def fetch options={}
        _fetch_url = self.respond_to?(:fetch_url, true) ? self.fetch_url : self.url

        @fetch_options = ::LoyalSpider::FetchOptions.new(
          ::LoyalSpider::HashUtil.deep_merge(self.class.default_fetch_options, options).merge(
            :url => _fetch_url
          )
        )

        ::RestClient::Request.execute @fetch_options.net_options do |response, request, response_result, &_block|
          response_code = response.code

          response_status = if (200..207).include?(response_code)
                              :success
                            elsif (300..307).include?(response_code)
                              :redirect
                            elsif (400..450).include?(response_code)
                              :request_error
                            else
                              :server_error
                            end

          _result = ::LoyalSpider::FetchResult.new(
            :response_status  => response_status,
            :response_code    => response_code,
            :response         => response.force_encoding(self.fetch_options.encoding_type).encode!('UTF-8'),
            :request          => request,
            :response_result  => response_result,
            :fetch_options    => self.fetch_options,
            :url              => _fetch_url
          )

          if block_given?
            block.call _result, &_block
          end

          _result
        end
      end
    end
  end
end