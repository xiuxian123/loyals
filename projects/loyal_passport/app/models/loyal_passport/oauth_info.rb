# -*- encoding : utf-8 -*-
module LoyalPassport
  class OauthInfo < ActiveRecord::Base
    # attr_accessible :title, :body

    # 缓存
    self.acts_as_tiny_cached

    validates_presence_of :access_token, :strategy_name, :strategy_id
    validates_inclusion_of :strategy_name, :in => ::User.omniauth_providers.map(&:to_s)

    scope :of_strategy, ->(strategy_name, strategy_id) {
      where(:strategy_id => strategy_id, :strategy_name => strategy_name)
    }

    has_many :oauth_binds,  :class_name => "LoyalPassport::OauthBind"
    has_many :bind_users,   :class_name => "User",
      :through => :oauth_binds, :source => :user

    has_one :oauth_login, :class_name => "LoyalPassport::OauthLogin"

    # 登录用户
    def login_user
      return @login_user if defined?(@login_user)

      self.login_user = self.oauth_login.nil? ? nil : self.oauth_login.user
    end

    def login_user= user
      @login_user = user
    end

    def self.omniauth_provider_names
      @omniauth_provider_names ||= ::User.omniauth_providers.map(&:to_s)
    end

    def self.providers_regexp
      @providers_regexp ||= Regexp.new(::User.omniauth_providers.join('|'))
    end

    # 来源名称
    def provider_name
      self.class.provider_name_of(self.strategy_name)
    end

    # 获取I18n名称
    def self.provider_name_of(strategy_name)
      I18n.t("devise.omniauth.providers.#{strategy_name}")
    end

    def self.save_with_callback_info strategy_name, strategy_id, info={}
      oauth_info_scope = self.where(
        :strategy_id   => strategy_id,
        :strategy_name => strategy_name
      )

      oauth_info = oauth_info_scope.first || oauth_info_scope.new

      oauth_info.access_token      = info['credentials']['token'].to_s
      oauth_info.access_secret     = info['credentials']['secret'].to_s
      oauth_info.expired_at        = Time.at(info['credentials']['expires_at'].to_i)
      oauth_info.origin_avatar_url = info['info']['avatar'].to_s
      oauth_info.gender            = info['info']['gender'].to_i
      oauth_info.nick_name         = info['info']['nick_name'].to_s
      oauth_info.email             = info['info']['email'].to_s

      info_urls = info['info']['urls'] || {}

      oauth_info.origin_home_url   = info_urls['home'].to_s
      oauth_info.origin_blog_url   = info_urls['blog'].to_s

      oauth_info.save

      oauth_info
    end

    # token是否过期
    def expired?
      self.blank? || (self.expires_at < Time.now)
    end

  end
end
