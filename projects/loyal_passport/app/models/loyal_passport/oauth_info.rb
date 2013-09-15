# -*- encoding : utf-8 -*-
module LoyalPassport
  class OauthInfo < ActiveRecord::Base
    # attr_accessible :title, :body

    validates_presence_of :access_token, :strategy_name, :strategy_id
    validates_inclusion_of :strategy_name, :in => ::User.omniauth_providers

    def self.providers_regexp
      @providers_regexp ||= Regexp.new(::User.omniauth_providers.join('|'))
    end

    def provider_name
      self.class.provider_name(self.strategy_name)
    end

    def self.provider_name(strategy_name)
      I18n.t("devise.omniauth.providers.#{strategy_name}")
    end

    def self.save_with_callback_info strategy_name, strategy_id, info={}
      oauth_info_scope = self.class.where(
        :strategy_name => strategy_name,
        :strategy_id   => strategy_id
      )

      oauth_info = oauth_info_scope.first || oauth_info_scope.new

      oauth_info.access_token      = info['credentials']['token']
      oauth_info.expired_at        = Time.at(info['credentials']['expires_at'].to_i)
      oauth_info.origin_avatar_url = info['info']['avatar']
      oauth_info.gender            = info['info']['gender']
      oauth_info.nick_name         = info['info']['nick_name']

      oauth_info.save
    end

    # token是否过期
    def expired?
      self.blank? || (self.expires_at < Time.now)
    end

  end
end
