# -*- encoding : utf-8 -*-
class CreateLoyalPassportOauthBinds < ActiveRecord::Migration
  def change
    create_table :loyal_passport_oauth_binds do |t|
      t.integer :oauth_info_id
      t.integer :user_id

      t.integer :status, :null => false, :default => 0

      t.text    :config_yaml

      t.timestamps
    end

    add_index :loyal_passport_oauth_binds, [:oauth_info_id]
    add_index :loyal_passport_oauth_binds, [:user_id]

  end
end
