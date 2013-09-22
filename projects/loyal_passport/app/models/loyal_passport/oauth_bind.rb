# -*- encoding : utf-8 -*-
module LoyalPassport
  class OauthBind < ActiveRecord::Base
    # attr_accessible :title, :body
    attr_accessible :user_id, :oauth_info_id

    # 缓存
    self.acts_as_tiny_cached

    # 绑定的第三方信息
    belongs_to :oauth_info, :class_name => "LoyalPassport::OauthInfo"
    belongs_to :user,       :class_name => "User"

  end
end
