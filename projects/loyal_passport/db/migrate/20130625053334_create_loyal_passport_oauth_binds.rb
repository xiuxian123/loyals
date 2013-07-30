# -*- encoding : utf-8 -*-
class CreateLoyalPassportOauthBinds < ActiveRecord::Migration
  def change
    create_table :loyal_passport_oauth_binds do |t|
      t.integer :auth_info_id
      t.integer :user_id

      t.text    :config

      t.timestamps
    end

    add_index :loyal_passport_oauth_binds, [:auth_info_id]
    add_index :loyal_passport_oauth_binds, [:user_id]

  end
end
