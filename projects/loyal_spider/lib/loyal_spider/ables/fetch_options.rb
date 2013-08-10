# -*- encoding : utf-8 -*-
module LoyalSpider
  class FetchOptions
    attr_accessor :method             # 抓取方法
    attr_accessor :open_timeout       # 打开超时配置
    attr_accessor :timeout            # 打开超时配置
    attr_accessor :encoding_type      # 编码
    attr_accessor :headers            # 请求头
    attr_accessor :url                # url

    def initialize attrs={}
      @url           = attrs[:url]       || ''
      @method        = attrs[:method]    || :get
      @timeout       = attrs[:timeout]   || 60  #  单位秒
      @open_timeout  = attrs[:open_time] || @timeout
      @encoding_type = attrs[:encoding_type] || 'UTF-8'
      @headers = {
        :accept_charset => 'UTF-8,*;q=0.5',
        :accept_encoding => 'gzip,deflate,sdch',
        :user_agent    => 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17'
      }.merge(attrs[:headers] || {})
    end

    def net_options
      {
        :url            => self.url,
        :method         => self.method,
        :timeout        => self.timeout,
        :open_timeout   => self.open_timeout,
        :encoding_type  => self.encoding_type,
        :headers        => self.headers
      }
    end

  end
end
