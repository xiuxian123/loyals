# -*- encoding : utf-8 -*-
module LoyalPassport
  class OauthLogin < ActiveRecord::Base
    attr_accessible :user_id, :oauth_info_id

    # 缓存
    self.acts_as_tiny_cached

    # 绑定的第三方登录信息
    belongs_to :oauth_info, :class_name => "LoyalPassport::OauthInfo"
    belongs_to :user,       :class_name => "User"

  end
end
