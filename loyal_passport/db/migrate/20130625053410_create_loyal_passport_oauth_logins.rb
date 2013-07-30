# -*- encoding : utf-8 -*-
class CreateLoyalPassportOauthLogins < ActiveRecord::Migration
  def change
    create_table :loyal_passport_oauth_logins do |t|
      t.integer :auth_info_id
      t.integer :user_id

      t.timestamps
    end

    add_index :loyal_passport_oauth_logins, [:auth_info_id], :name => :loyal_passport_oauth_logins_info
    add_index :loyal_passport_oauth_logins, [:user_id],      :name => :loyal_passport_oauth_logins_user

  end
end
