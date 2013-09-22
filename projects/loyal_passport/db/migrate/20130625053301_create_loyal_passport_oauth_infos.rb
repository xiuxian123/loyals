# -*- encoding : utf-8 -*-
class CreateLoyalPassportOauthInfos < ActiveRecord::Migration
  def change
    create_table :loyal_passport_oauth_infos do |t|
      # 第三方标识
      t.string   :strategy_name,        :null => false

      # 第三方ID
      t.string     :strategy_id,          :default => '',   :null => false

      t.string     :access_token,         :default => '',   :null => false
      t.string     :access_secret,        :default => '',   :null => false
      t.string     :nick_name,            :default => '',   :null => false

      # 邮箱地址
      t.string     :email,                :default => '',   :null => false

      # 本地头像
      t.string     :avatar,               :null => false,   :default => ''

      # 远程的头像URL
      t.string     :origin_avatar_url,    :null => false,   :default => ''

      # 远程的主页地址
      t.string     :origin_home_url,      :null => false,  :default => ''

      # 博客地址
      t.string     :origin_blog_url,      :null => false,  :default => ''

      # Raw Info
      t.text       :raw_info_yaml

      # 性别
      t.integer    :gender,               :null => false,   :default => 0

      t.datetime   :expired_at

      t.timestamps
    end

    add_index :loyal_passport_oauth_infos, [:access_secret]
    add_index :loyal_passport_oauth_infos, [:access_token]
    add_index :loyal_passport_oauth_infos, [:strategy_id, :strategy_name], :name => :loyal_passport_oauth_infos_strategy

  end
end
