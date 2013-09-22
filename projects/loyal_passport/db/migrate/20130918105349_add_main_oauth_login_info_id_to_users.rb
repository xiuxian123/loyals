class AddMainOauthLoginInfoIdToUsers < ActiveRecord::Migration
  def change
    # 主要的oauth登录ID
    add_column :users, :main_oauth_login_info_id, :integer, :default => 0, :null => false
  end
end
