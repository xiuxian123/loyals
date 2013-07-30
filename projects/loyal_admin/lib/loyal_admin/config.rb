# -*- encoding : utf-8 -*-
module LoyalAdmin
  class << self
    attr_accessor :config

    def configure
      yield self.config ||= Config.new
    end

  end

  DEFAULT_SUBDOMAIN = 'admin'.freeze


  DEFAULT_WHITE_HOSTS = {}.freeze

  DEFAULT_INFO_CONFIGS = {
    :title => 'Loyal Admin'
  }.freeze

  class Config
    def info_config
      @info_config ||= DEFAULT_INFO_CONFIGS
    end

    def info_config= info=DEFAULT_INFO_CONFIGS
      @info_config ||= (
        DEFAULT_INFO_CONFIGS.merge(info)
      )
    end

    def white_hosts= hosts=DEFAULT_WHITE_HOSTS
      @white_hosts ||= (
        DEFAULT_WHITE_HOSTS.merge(hosts)
      )
    end

    def white_hosts
      @white_hosts ||= DEFAULT_WHITE_HOSTS
    end

    def prepend_view_paths
      @prepend_view_paths ||= (
        self.white_hosts.inject({}) do |result, pair|
          host, config = pair

          if config[:view_paths]
            result[host] = ::LoyalCore::ArrayUtil.init(config[:view_paths])
          end

          result
        end
      )
    end

    def subdomain= subdomain=DEFAULT_SUBDOMAIN
      @subdomain ||= subdomain
    end

    def subdomain
      @subdomain ||= DEFAULT_SUBDOMAIN
    end

    # 判断请求是否可以路由到passport中来
    def request_routes_constraints?(request)
      request.subdomain == self.subdomain
    end

  end
end

