# -*- encoding : utf-8 -*-
module LoyalPassport
  class << self
    attr_accessor :config
    def configure
      yield self.config ||= Config.new
    end
  end

  # 缺省的域名配置
  # DEFAULT_HOST = 'passport.ruby800.com'
  DEFAULT_SUBDOMAIN = 'passport'

  # 缺省的数据库配置
  DEFAULT_DB_CONFIG = {

  }

  DEFAULT_WHITE_HOSTS = {}.freeze

  DEFAULT_AUTHORITY_CONFIGS = {
    'user' => {
      :desc => '用户管理',
      :jobs => {
        'review' => '审核'
      }
    }
  }

  DEFAULT_ABILITYS = [
    'LoyalPassport::Ability'
  ].freeze

  # 缺省的逻辑
  DEFAULT_LOGICS = {
    :open_account_cancel? => false # 开启账户注销
  }.freeze

  class Config
    def initialize
      ### Warden config ###############################
      #   Warden::Manager.before_failure do |env, opts|
      #     params = Rack::Request.new(env).params
      #     params[:action] = :unauthenticated
      #     params[:warden_failure] = opts
      #   end

      Warden::Manager.before_failure do |env, opts|
      #   params = Rack::Request.new(env).params
      #   params[:action] = :unauthenticated
      #   params[:warden_failure] = opts
      end
    end

    def white_hosts= hosts=DEFAULT_WHITE_HOSTS
      @white_hosts ||= (
        DEFAULT_WHITE_HOSTS.merge(hosts)
      )
    end

    def white_hosts
      @white_hosts ||= DEFAULT_WHITE_HOSTS
    end

    def logics
      @logics ||= DEFAULT_LOGICS
    end

    def logics= logics={}
      @logics ||= (
        DEFAULT_LOGICS.merge(
          logics
        )
      )
    end

    def prepend_view_paths
      @prepend_view_paths ||= (
        self.white_hosts.inject({}) do |result, pair|
          host, config = pair

          if config[:view_paths]
            result[host] = ::LoyalPassport::ArrayUtil.init(config[:view_paths])
          end

          result
        end
      )
    end

    def db
      @db_configs ||= DEFAULT_DB_CONFIG
    end

    def db= options={}
      @db_configs ||= DEFAULT_DB_CONFIG.merge(
        options
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
      request.subdomain == self.subdomain && self.white_hosts[request.host]
    end

    def cancan_abilities= abilities=[]
      @cancan_abilities ||= (
        DEFAULT_ABILITYS + abilities
      )
    end

    def cancan_abilities
      @cancan_abilities ||= DEFAULT_ABILITYS
    end

    def authoritie_configs= config={}
      @authoritie_configs ||= DEFAULT_AUTHORITY_CONFIGS.deep_merge(
        config
      )
    end

    # 权限定义
    def authoritie_configs
      @authoritie_configs ||= DEFAULT_AUTHORITY_CONFIGS
    end

    def resuce_cancan_access_denied_call
      [
        :render,
        'loyal_passport/error/access_deny', {
          :layout => 'loyal_passport/application',
          :status => :forbidden
        }
      ]
    end

    # usage:
    #   devise_install do |config|
    #     config.mailer_sender = ''
    #   end
    def devise_install(&block)
      if block_given?
        Devise.setup do |config|
          block.call config
        end
      end
    end
  end
end

