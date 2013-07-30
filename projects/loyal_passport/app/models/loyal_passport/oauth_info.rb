# -*- encoding : utf-8 -*-
module LoyalPassport
  class OauthInfo < ActiveRecord::Base
    # attr_accessible :title, :body
    STRATEGY_MAP_CONFIG = {
      :github     => { :value => 1, :name => 'Github' },
      :qq_connect => { :value => 2, :name => "QQ"}
    }.freeze

    STRATEGY_VALUES = STRATEGY_MAP_CONFIG.values.map do |_config|
      _config[:value]
    end.freeze

    validates_inclusion_of :strategy_flag, :in => STRATEGY_VALUES

    def self.save_with_callback_info strategy_name, strategy_id, info={}
      strategy_flag = STRATEGY_MAP_CONFIG[strategy_name.to_sym][:value]

      oauth_info_scope = self.class.where(
        :strategy_flag => strategy_flag,
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

  end
end
