# -*- encoding : utf-8 -*-
class CreateUsers < ActiveRecord::Migration
  def change
    # 创建用户表
    create_table :users do |t|
      t.string :true_name,          :null => false, :default => ''
      t.string :nick_name,          :null => false, :default => ''
      t.string :permalink,          :null => false, :default => ''

      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## mobile_number
      t.string :mobile_number,      :null => false, :default => ''

      ## mobile Confirmable
      t.string   :mobile_confirmation_token
      t.datetime :mobile_confirmed_at
      t.datetime :mobile_confirmation_sent_at
      t.string   :unconfirmed_mobile              # Only if using reconfirmable

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email              # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token                   # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Token authenticatable
      t.string :authentication_token

      ###### avatar #############################
      t.string :avatar

      ##### soft deleted #######################
      t.datetime :deleted_at

      # 发布状态 ###############################
      t.integer :publish_status, default: 0, :null => false

      t.timestamps
    end

    add_index :users, :true_name
    add_index :users, :nick_name
    add_index :users, :permalink
    add_index :users, :mobile_number
    add_index :users, :email
    add_index :users, :reset_password_token, :unique => true

    # #########################################################
    add_index :users, :mobile_confirmation_token,   :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true
    add_index :users, :authentication_token, :unique => true

    # #########################################################
    add_index :users, :unconfirmed_email
    add_index :users, :unconfirmed_mobile
  end
end
